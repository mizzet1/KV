defmodule KvStoreWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :kv_store

  @session_options [
    store: :cookie,
    key: "_kv_store_key",
    signing_salt: "ctT7kJ67",
    same_site: "Lax"
  ]

  socket("/live", Phoenix.LiveView.Socket)

  plug(Plug.Static,
    at: "/",
    from: :kv_store,
    gzip: false,
    only: KvStoreWeb.static_paths()
  )

  if code_reloading? do
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.RequestId)
  plug(Plug.Telemetry, event_prefix: [:phoenix, :endpoint])

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)
  plug(Plug.Session, @session_options)
  plug(KvStoreWeb.Router)
end