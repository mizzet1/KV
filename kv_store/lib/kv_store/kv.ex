defmodule KvStore.KV do
  use GenServer

  @table :kv_store

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get(key) do
    :telemetry.span([:kv_store, :operation], %{operation: :get}, fn ->
      result =
        case :ets.lookup(@table, key) do
          [{^key, value}] -> {:ok, value}
          [] -> :error
        end

      {result, %{key: key}}
    end)
    |> elem(0)
  end

  def put(key, value) do
    :telemetry.span([:kv_store, :operation], %{operation: :put}, fn ->
      :ets.insert(@table, {key, value})
      {:ok, %{key: key}}
    end)
    |> elem(0)
  end

  def delete(key) do
    :telemetry.span([:kv_store, :operation], %{operation: :delete}, fn ->
      :ets.delete(@table, key)
      {:ok, %{key: key}}
    end)
    |> elem(0)
  end

  def init(_) do
    :ets.new(@table, [:named_table, :set, :public])
    {:ok, %{}}
  end
end
