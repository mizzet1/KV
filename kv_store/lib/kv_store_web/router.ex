defmodule KvStoreWeb.Router do
  use KvStoreWeb, :router

  import Phoenix.LiveDashboard.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KvStoreWeb do
    pipe_through :api

    get "/kv/:key", KVController, :get
    put "/kv", KVController, :put
    delete "/kv/:key", KVController, :delete
  end

  if Mix.env() in [:dev, :test] do
    scope "/" do
      pipe_through :api
      live_dashboard "/dashboard", metrics: KvStore.Metrics
    end
  end
end
