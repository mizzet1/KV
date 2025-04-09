defmodule KvStoreWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Phoenix.ConnTest
      import Plug.Conn
      import KvStoreWeb.ConnCase

      alias KvStoreWeb.Router.Helpers, as: Routes

      @endpoint KvStoreWeb.Endpoint
    end
  end

  setup _tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
