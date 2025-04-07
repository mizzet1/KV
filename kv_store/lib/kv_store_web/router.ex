defmodule KvStoreWeb.Router do
  use KvStoreWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KvStoreWeb do
    pipe_through :api

    get "/kv/:key", KVController, :get
    post "/kv", KVController, :put
    delete "/kv/:key", KVController, :delete
  end
end


