defmodule KvStore.KV do
  use GenServer

  @table :kv_store

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get(key) do
    :telemetry.span([:kv_store, :operation], %{operation: :get}, fn ->
      result = case :ets.lookup(@table, key) do
        [{^key, value}] -> {:ok, value}
        [] -> :error
      end
      response = case result do
        {:ok, value} -> %{status: "ok", key: key, value: value}
        :error -> %{status: "error", message: "Key not found"}
      end

      # Return the response as a map, not a tuple
      %{result: response}
    end)
  end

  def put(key, value) do
    :telemetry.span([:kv_store, :operation], %{operation: :put}, fn ->
      :ets.insert(@table, {key, value})

     
      response = %{status: "ok", message: "Value inserted"}

      %{result: response}  # Return a map
    end)
  end

  def delete(key) do
    :telemetry.span([:kv_store, :operation], %{operation: :delete}, fn ->
      :ets.delete(@table, key)

    
      response = %{status: "ok", message: "Key deleted"}

      %{result: response}  # Return a map
    end)
  end

  def init(_) do
    :ets.new(@table, [:named_table, :set, :public])
    {:ok, %{}}
  end
end

