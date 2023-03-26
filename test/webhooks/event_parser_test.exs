defmodule LemonEx.Webhooks.EventParserTest do
  use ExUnit.Case
  use Plug.Test

  import Plug.Conn

  alias LemonEx.Webhooks.EventParser

  @endpoint "/webhook/lemonsqueezy"
  @valid_payload ~S({"meta": {"event_name": "order_created", "custom_data": {"customer_id": 25}}})

  describe "parse/1" do
    test "returns an error if no x-signature exists" do
      conn = conn(:post, @endpoint)
      assert {:error, 400, "X-Signature missing."} = EventParser.parse(conn, nil)
    end

    test "returns an error if the signature doesn't match the payload hash" do
      conn =
        conn(:post, @endpoint)
        |> put_private(:raw_body, @valid_payload)
        |> put_req_header("x-signature", "foobar")

      assert {:error, 400, "Signature and Payload Hash unequal."} = EventParser.parse(conn, nil)
    end
  end

  defp generate_signature_header(payload) do
    code = :crypto.mac(:hmac, :sha256, @secret, payload)

    signature =
      code
      |> Base.encode16(case: :lower)
  end
end
