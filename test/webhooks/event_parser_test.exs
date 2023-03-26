defmodule LemonEx.Webhooks.EventParserTest do
  use ExUnit.Case
  use Plug.Test

  import Plug.Conn
  import Support.Fixtures

  alias LemonEx.Webhooks.EventParser

  @endpoint "/webhook/lemonsqueezy"

  describe "parse/1" do
    test "returns an error if no x-signature exists" do
      conn = conn(:post, @endpoint)
      assert {:error, 400, "X-Signature missing."} = EventParser.parse(conn, nil)
    end

    test "returns an error if the signature doesn't match the payload hash" do
      {_payload, raw_payload} = load_json(:event)

      conn =
        conn(:post, @endpoint)
        |> put_private(:raw_body, raw_payload)
        |> put_req_header("x-signature", "foobar")

      assert {:error, 400, "Signature and Payload Hash unequal."} = EventParser.parse(conn, nil)
    end

    test "returns an event if successful" do
      {payload, raw_payload} = load_json(:event)
      signature = generate_signature_header(raw_payload)

      conn =
        conn(:post, @endpoint)
        |> put_private(:raw_body, raw_payload)
        |> put_req_header("x-signature", signature)

      assert {:ok, event} = EventParser.parse(conn, payload)

      assert event.name == "order_created"
      assert event.meta["custom_data"]["customer_id"] == 25

      assert %LemonEx.Orders.Order{} = event.data
      assert event.data.identifier == "636f855c-1fb9-4c07-b75c-3a10afef010a"
    end
  end

  defp generate_signature_header(payload) do
    code = :crypto.mac(:hmac, :sha256, secret(), payload)
    Base.encode16(code, case: :lower)
  end

  defp secret(), do: Application.get_env(:lemon_ex, :webhook_secret)
end
