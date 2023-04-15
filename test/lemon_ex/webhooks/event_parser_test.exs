defmodule LemonEx.Webhooks.EventParserTest do
  use Support.ConnCase

  alias LemonEx.Webhooks.EventParser

  @endpoint "/webhook/lemonsqueezy"

  describe "parse/1" do
    test "returns an error if no x-signature exists" do
      conn = conn(:post, @endpoint)
      assert {:error, 400, "X-Signature missing."} = EventParser.parse(conn)
    end

    test "returns an error if the signature doesn't match the payload hash" do
      raw_payload = load_json(:order_created_event)

      conn =
        conn(:post, @endpoint, raw_payload)
        |> put_req_header("x-signature", "foobar")

      assert {:error, 400, "Signature and Payload Hash unequal."} = EventParser.parse(conn)
    end

    test "returns an event if successful" do
      raw_payload = load_json(:order_created_event)
      signature = gen_signature(raw_payload)

      conn =
        conn(:post, @endpoint, raw_payload)
        |> put_req_header("x-signature", signature)

      assert {:ok, event} = EventParser.parse(conn)

      assert event.name == "order_created"
      assert event.meta["custom_data"]["customer_id"] == 25

      assert %LemonEx.Orders.Order{} = event.data
      assert event.data.identifier == "636f855c-1fb9-4c07-b75c-3a10afef010a"
    end

    test "can parse subscription_created event" do
      raw_payload = load_json(:subscription_created_event)
      signature = gen_signature(raw_payload)

      conn =
        conn(:post, @endpoint, raw_payload)
        |> put_req_header("x-signature", signature)

      assert {:ok, event} = EventParser.parse(conn)

      assert event.name == "subscription_created"
      assert event.meta["custom_data"]["user_id"] == 25

      assert %LemonEx.Subscriptions.Subscription{} = event.data
      assert event.data.customer_id == 1
      assert event.data.card_brand == "visa"
      assert event.data.card_last_four == "4242"
      assert event.data.renews_at == "2023-05-14T17:17:01.000000Z"
    end
  end
end
