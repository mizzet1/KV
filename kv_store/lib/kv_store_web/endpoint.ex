defmodule KvStoreWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :kv_store

  @session_options [
    store: :cookie,
    key: "_kv_store_key",
    signing_salt: "ctT7kJ67",
    same_site: "Lax"
  ]

  # Remove the LiveView socket, if not using LiveView
  # socket "/live", Phoenix.LiveView.Socket,
  #   websocket: [connect_info: [session: @session_options]],
  #   longpoll: [connect_info: [session: @session_options]]

  plug Plug.Static,
    at: "/",
    from: :kv_store,
    gzip: false,
    only: KvStoreWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    # Removed the line below since you're not using Ecto
    # plug Phoenix.Ecto.CheckRepoStatus, otp_app: :kv_store
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug KvStoreWeb.Router
end
