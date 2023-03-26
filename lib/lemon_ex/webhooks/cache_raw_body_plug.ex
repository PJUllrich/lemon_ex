defmodule LemonEx.Webhooks.CacheRawBodyPlug do
  @moduledoc """
  A Plug that caches the raw request body. That is, before
  the body is decoded automatically by Phoenix.

  Based on [this](https://github.com/phoenixframework/phoenix/issues/459#issuecomment-491288847) GitHub comment :heart:

  Use it in your `endpoint.ex` like this:

  ```elixir
  defmodule MyAppWeb.Endpoint do
    # Other Stuff

    plug LemonEx.Webhooks.CacheRawBodyPlug

    # The Plug.Parsers MUST come AFTER the CacheRawBodyPlug
    plug Plug.Parsers,
      # Other Options
  end
  ```

  You can then fetch the raw body in e.g. a Controller like this:

  ```elixir
  defmodule MyAppWeb.MyController do
    def create(conn, _params) do
      raw_body = LemonEx.Webhooks.CacheRawBodyPlug.get_raw_body(conn)
    end
  end
  ```
  """

  @behaviour Plug

  @impl true
  def init(opts), do: opts

  @impl true
  def call(conn, opts) do
    {:ok, body, conn} = Plug.Conn.read_body(conn, opts)
    Plug.Conn.put_private(conn, :raw_body, body)
  end

  def get_raw_body!(conn) do
    Map.fetch!(conn.private, :raw_body)
  end
end
