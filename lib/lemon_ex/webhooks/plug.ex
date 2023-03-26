defmodule LemonEx.Webhooks.Plug do
  @moduledoc """
  A plug that receives, verifies, and handles Webhook Events sent by LemonSqueezy.

  If you want to handle Webhook Events, you must do two things:

  ### 1. Create an event handler

  Create a new module that implements the callback:
  ```
  handle_event(%LemonEx.Webhooks.Event{}) :: :ok | {:error, reason}
  ```

  The handler module should call your application logic and return
  either `:ok`  or `{:error, message}`.

  For example:
  ```
  defmodule MyAppWeb.MyWebhookHandler do
    def handle_event(%LemonEx.Webhooks.Event{name: "order_created"} = event) do
      # The event.data holds the object of the event,
      # like e.g. an `LemonEx.Orders.Order{}`.
      new_order = event.data

      # do something with the new order

      # Return either :ok or {:error, error_message}
      :ok
    end

    # You need to handle all incoming events. So, better have a
    # catch-all handler for events that you don't want to handle,
    # but only want to acknowledge.
    def handle_event(_unhandled_event), do: :ok
  end
  ```

  ### 2. Add the LemonEx.Webhooks.Plug to your Endpoint
  In your `endpoint.ex`, add the `LemonEx.Webhooks.Plug` **before** the `Plug.Parsers`-plug.

  ```elixir
  # In your endpoint.ex
  plug LemonEx.Webhooks.Plug,
    at: "/webhooks/lemonsqueezy",
    handler: MyAppWeb.MyHandler

  # Make sure that this plug comes after the LemonEx plug.
  plug Plug.Parsers
  ```
  """

  alias LemonEx.Webhooks.EventParser

  import Plug.Conn

  @behaviour Plug

  @impl true
  def init(opts) do
    path_info = String.split(opts[:at], "/", trim: true)

    handler =
      opts[:handler] ||
        raise """
        You must provide a handler module to the LemonEx Plug.

        When you add the plug to your "endpoint.ex", you can specify the handler like this:

          plug LemonEx.Webhooks.Plug,
            at: "/webhooks/lemonsqueezy",
            handler: MyAppWeb.MyHandler

        """

    %{
      path_info: path_info,
      handler: handler
    }
  end

  @impl true
  def call(
        %Plug.Conn{method: "POST", path_info: conn_path_info} = conn,
        %{handler: handler, path_info: opts_path_info} = _opts
      )
      when conn_path_info == opts_path_info do
    with {:ok, event} <- EventParser.parse(conn),
         :ok <- handler.handle_event(event) do
      respond(conn, 200, "Webhook received.")
    else
      {:error, status, reason} -> respond(conn, status, reason)
      {:error, reason} -> respond(conn, 400, reason)
    end
  end

  @impl true
  def call(conn, _opts), do: conn

  defp respond(conn, status, message) do
    conn
    |> send_resp(status, message)
    |> halt()
  end
end
