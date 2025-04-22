defmodule KvStoreWeb.Telemetry do
  use Supervisor
  import Telemetry.Metrics

  def start_link(_arg) do
    Supervisor.start_link(__MODULE__, [])
  end

  @impl true
  def init(_) do
    children = []

    Supervisor.init(children, strategy: :one_for_one)
  end

  def metrics do
    [
      summary("kv_store.operation.latency",
        unit: {:native, :millisecond},
        tags: [:operation],
        description: "Time taken for KV store operations (get, put, delete)"
      ),
      counter("kv_store.operation.count",
        tags: [:operation],
        description: "Total number of KV store operations"
      )
    ]
  end
end
