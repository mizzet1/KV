import Config

if config_env() == :prod do
  config :kv_store, KvStoreWeb.Endpoint,
    url: [host: "localhost"],
    http: [ip: {0, 0, 0, 0}, port: String.to_integer(System.get_env("PORT") || "4000")],
    secret_key_base: String.duplicate("a", 64),
    server: true
end
