defmodule KvStoreWeb.KVController do
  use KvStoreWeb, :controller
  alias KvStore.KV

  def get(conn, %{"key" => key}) do
    case KV.get(key) do
      {:ok, value} -> json(conn, %{key: key, value: value})
      {:error, :not_found} -> send_resp(conn, 404, "Key not found")
      {:error, reason} -> send_resp(conn, 500, "Internal error: #{reason}")
      unexpected -> send_resp(conn, 500, "Unexpected error: #{inspect(unexpected)}")
    end
  end

  def put(conn, %{"key" => key, "value" => value}) do
    case KV.put(key, value) do
      {:ok, _} -> json(conn, %{status: "ok"})
      {:error, reason} -> send_resp(conn, 500, "Failed to insert: #{reason}")
      unexpected -> send_resp(conn, 500, "Unexpected error: #{inspect(unexpected)}")
    end
  end

  def delete(conn, %{"key" => key}) do
    case KV.delete(key) do
      {:ok, _} -> json(conn, %{status: "deleted"})
      {:error, reason} -> send_resp(conn, 500, "Failed to delete: #{reason}")
      unexpected -> send_resp(conn, 500, "Unexpected error: #{inspect(unexpected)}")
    end
  end
end
