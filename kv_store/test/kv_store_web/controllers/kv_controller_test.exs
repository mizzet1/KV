defmodule KvStoreWeb.KVControllerTest do
  use KvStoreWeb.ConnCase, async: false  

  @key "test_key"
  @value "test_value"

  describe "PUT /api/kv" do
    test "stores a key-value pair", %{conn: conn} do
      conn = put(conn, "/api/kv", %{"key" => @key, "value" => @value})
      assert json_response(conn, 200) == %{"status" => "ok"}  
      assert {:ok, @value} == KvStore.KV.get(@key)
    end
  end

  describe "GET /api/kv/:key" do
    test "retrieves an existing key", %{conn: conn} do
      KvStore.KV.put(@key, @value)    
      conn = get(conn, "/api/kv/#{@key}")
      assert json_response(conn, 200) == %{"key" => @key, "value" => @value}
    end

    test "returns 404 for missing key", %{conn: conn} do
      conn = get(conn, "/api/kv/nonexistent_key")
      assert conn.status == 404
      assert conn.resp_body == "Key not found"
    end
  end

  describe "DELETE /api/kv/:key" do
    test "deletes an existing key", %{conn: conn} do
      KvStore.KV.put(@key, @value)  
      conn = delete(conn, "/api/kv/#{@key}")
      assert json_response(conn, 200) == %{"status" => "deleted"}
      assert :error == KvStore.KV.get(@key)
    end
  end

end