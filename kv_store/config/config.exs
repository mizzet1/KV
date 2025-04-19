# config/config.exs
import Config

config :kv_store,
  ecto_repos: [KvStore.Repo],
  generators: [timestamp_type: :utc_datetime]

config :kv_store, KvStoreWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: KvStoreWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: KvStore.PubSub,
  live_view: [signing_salt: "GDdbXmzi5YAgpRgI"]  

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
