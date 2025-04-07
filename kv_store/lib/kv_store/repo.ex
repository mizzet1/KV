defmodule KvStore.Repo do
  use Ecto.Repo,
    otp_app: :kv_store,
    adapter: Ecto.Adapters.Postgres
end
