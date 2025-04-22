defmodule KvStoreWeb.Telemetry do
  import Telemetry.Metrics

  def metrics do
    [
      summary("kv store calls latency",
        unit: {:native, :millisecond},
        tags: [:operation],
        description: "Time taken for KV store operations (get, put, delete)"
      ),
      counter("kv store calls count",
        tags: [:operation],
        description: "Total number of KV store operations"
      )
    ]
  end
end
