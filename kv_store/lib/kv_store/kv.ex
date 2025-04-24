defmodule KvStore.KV do
  use GenServer

  @table :kv_store

  # The API for the Client

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get(key) do
    case :ets.lookup(@table, key) do
      [{^key, value}] -> {:ok, value}
      [] -> :error
    end
  end

  def put(key, value) do
    :ets.insert(@table, {key, value})
    :ok
  end

  def delete(key) do
    :ets.delete(@table, key)
    :ok
  end

  def init(_) do
    :ets.new(@table, [:named_table, :set, :public])
    {:ok, %{}}
  end
end