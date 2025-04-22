defmodule KvStore.Application do
  use Application

  def start(_type, _args) do
    children = [
      KvStore.KV,
      KvStoreWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: KvStore.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
