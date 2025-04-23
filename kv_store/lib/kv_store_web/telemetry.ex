defmodule KvStoreWeb.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    attach_handlers()

    children = [
      {Telemetry.Metrics.ConsoleReporter, metrics: metrics()}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp attach_handlers do
    :telemetry.attach(
      "kv-store-metrics-handler",
      [:kv_store, :operation, :stop],
      &__MODULE__.handle_event/4,
      nil
    )
  end

  def handle_event([:kv_store, :operation, :stop], measurements, metadata, _config) do
    :telemetry.execute([:kv_store, :operation, :duration], measurements, metadata)
    :telemetry.execute([:kv_store, :operation, :count], %{value: 1}, metadata)
  end

  def metrics do
    [
      summary("kv_store.operation.duration",
        unit: {:native, :millisecond},
        tags: [:operation],
        description: "Time taken for KV store operations"
      ),
      counter("kv_store.operation.count",
        tags: [:operation],
        description: "Count of KV store operations"
      )
    ]
  end
end
