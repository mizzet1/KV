defmodule KvStoreWeb.MetricsControllerTest do
  use KvStoreWeb.ConnCase

  test "GET /api/metrics returns operation metrics", %{conn: conn} do
    KvStore.KV.put("test", "value")
    KvStore.KV.get("test")
    KvStore.KV.delete("test")

    conn = get(conn, "/api/metrics")
    assert %{"delete" => _, "get" => _, "put" => _} = json_response(conn, 200)
  end
end