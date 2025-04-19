defmodule KvStore.Metrics do
  use Supervisor
  import Telemetry.Metrics

  def start_link(_arg), do: Supervisor.start_link(__MODULE__, [])

  def init(_) do
    children = [
      {Telemetry.Metrics.ConsoleReporter, metrics: metrics()},
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp metrics do
    [
      summary("phoenix.endpoint.stop.duration", unit: {:native, :millisecond}),
      summary("phoenix.router_dispatch.stop.duration", tags: [:route], unit: {:native, :millisecond}),
      summary("kv_store.latency.duration", tags: [:operation], unit: {:native, :millisecond})
    ]
  end
end