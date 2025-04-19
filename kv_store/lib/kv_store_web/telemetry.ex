defmodule KvStoreWeb.Telemetry do
  import Telemetry.Metrics

  def metrics do
    [
      summary("kv_store.latency.duration",
        unit: {:native, :millisecond},
        tags: [:operation],
        description: "KV operation latency"
      )
    ]
  end
end