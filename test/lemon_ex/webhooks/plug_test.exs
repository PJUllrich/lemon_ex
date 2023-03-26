defmodule LemonEx.Webhooks.PlugTest do
  use Support.ConnCase

  alias LemonEx.Webhooks.Plug, as: WebhookPlug

  @me __MODULE__

  @endpoint "/webhook/lemonsqueezy"

  @opts WebhookPlug.init(
          at: "/webhook/lemonsqueezy",
          handler: __MODULE__.Handler
        )

  defmodule Handler do
    alias LemonEx.Webhooks.Event
    def handle_event(%Event{name: "order_created"}), do: :ok
    def handle_event(%Event{name: "bad-event"}), do: {:error, "Bad event."}
  end

  describe "init/1" do
    test "raises an exception if the :at option is missing" do
      assert_raise RuntimeError, fn ->
        WebhookPlug.init(handler: @me.Handler)
      end
    end

    test "raises an exception if the :handler option is missing" do
      assert_raise RuntimeError, fn ->
        WebhookPlug.init(at: "/webhook/lemonsqueezy")
      end
    end

    test "returns valid options" do
      opts = WebhookPlug.init(at: "/webhook/lemonsqueezy", handler: @me.Handler)

      assert opts.path_info == ["webhook", "lemonsqueezy"]
      assert opts.handler == @me.Handler
    end
  end

  describe "call/2" do
    setup do
      raw_payload = load_json(:event)

      %{raw_payload: raw_payload}
    end

    test "does nothing for other routes" do
      conn = conn(:post, "/foobar")
      conn = WebhookPlug.call(conn, @opts)

      refute conn.halted
    end

    test "returns 400 if the x-signature is missing" do
      conn = conn(:post, @endpoint)
      conn = WebhookPlug.call(conn, @opts)

      assert conn.halted
      assert conn.status == 400
      assert conn.resp_body == "X-Signature missing."
    end

    test "returns 400 if the x-signature is invalid", %{raw_payload: raw_payload} do
      conn =
        conn(:post, @endpoint, raw_payload)
        |> put_req_header("x-signature", "foobar")

      conn = WebhookPlug.call(conn, @opts)

      assert conn.halted
      assert conn.status == 400
      assert conn.resp_body == "Signature and Payload Hash unequal."
    end

    test "returns 200 if the handler succeeds", %{raw_payload: raw_payload} do
      signature = gen_signature(raw_payload)

      conn =
        conn(:post, @endpoint, raw_payload)
        |> put_req_header("x-signature", signature)

      conn = WebhookPlug.call(conn, @opts)

      assert conn.halted
      assert conn.status == 200
      assert conn.resp_body == "Webhook received."
    end

    test "returns 400 if the handler fails", %{raw_payload: raw_payload} do
      raw_payload =
        raw_payload
        |> Jason.decode!()
        |> put_in(["meta", "event_name"], "bad-event")
        |> Jason.encode!()

      signature = gen_signature(raw_payload)

      conn =
        conn(:post, @endpoint, raw_payload)
        |> put_req_header("x-signature", signature)

      conn = WebhookPlug.call(conn, @opts)

      assert conn.halted
      assert conn.status == 400
      assert conn.resp_body == "Bad event."
    end

    test "crashes if the handler implement no handler for the event", %{raw_payload: raw_payload} do
      raw_payload =
        raw_payload
        |> Jason.decode!()
        |> put_in(["meta", "event_name"], "foo")
        |> Jason.encode!()

      signature = gen_signature(raw_payload)

      conn =
        conn(:post, @endpoint, raw_payload)
        |> put_req_header("x-signature", signature)

      assert_raise FunctionClauseError, fn ->
        WebhookPlug.call(conn, @opts)
      end
    end
  end
end
