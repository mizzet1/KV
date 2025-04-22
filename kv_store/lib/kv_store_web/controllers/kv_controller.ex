defmodule KvStoreWeb.KVController do
  use KvStoreWeb, :controller
  alias KvStore.KV

  def get(conn, %{"key" => key}) do
    case KV.get(key) do
      {:ok, value} ->
        json(conn, %{key: key, value: value})

      :error ->
        send_resp(conn, 404, "Key not found")
    end
  end

  def put(conn, %{"key" => key, "value" => value}) do
    case KV.put(key, value) do
      :ok -> json(conn, %{status: "ok"})
      {:error, reason} -> send_resp(conn, 500, reason)
    end
  end

  def delete(conn, %{"key" => key}) do
    case KV.delete(key) do
      :ok -> json(conn, %{status: "deleted"})
      {:error, reason} -> send_resp(conn, 500, reason)
    end
  end
end
