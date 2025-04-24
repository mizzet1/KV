defmodule KvStoreWeb.KVController do
  use KvStoreWeb, :controller

  alias KvStore.KV

  def get(conn, %{"key" => key}) do
    case KV.get(key) do
      {:ok, value} -> json(conn, %{key: key, value: value})
      :error -> send_resp(conn, 404, "Key not found")
    end
  end

  def put(conn, %{"key" => key, "value" => value}) do
    KV.put(key, value)
    json(conn, %{status: "ok"})
  end

  def delete(conn, %{"key" => key}) do
    KV.delete(key)
    json(conn, %{status: "deleted"})
  end
end
