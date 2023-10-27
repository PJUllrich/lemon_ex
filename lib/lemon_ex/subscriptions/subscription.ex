defmodule LemonEx.Subscriptions.Subscription do
  defstruct [
    :id,
    :store_id,
    :order_id,
    :order_item_id,
    :product_id,
    :variant_id,
    :product_name,
    :variant_name,
    :user_name,
    :user_email,
    :customer_id,
    :status,
    :status_formatted,
    :pause,
    :cancelled,
    :trial_ends_at,
    :billing_anchor,
    :urls,
    :renews_at,
    :ends_at,
    :created_at,
    :updated_at,
    :test_mode,
    :card_brand,
    :card_last_four
  ]

  def from_json(body) do
    attributes = body["attributes"]
    urls = attributes["urls"]

    %__MODULE__{
      id: body["id"],
      store_id: attributes["store_id"],
      order_id: attributes["order_id"],
      order_item_id: attributes["order_item_id"],
      product_id: attributes["product_id"],
      variant_id: attributes["variant_id"],
      product_name: attributes["product_name"],
      variant_name: attributes["variant_name"],
      user_name: attributes["user_name"],
      user_email: attributes["user_email"],
      customer_id: attributes["customer_id"],
      status: attributes["status"],
      status_formatted: attributes["status_formatted"],
      pause: attributes["pause"],
      cancelled: attributes["cancelled"],
      billing_anchor: attributes["billing_anchor"],
      trial_ends_at: attributes["trial_ends_at"],
      urls: %{
        update_payment_method: urls["update_payment_method"],
        customer_portal: urls["customer_portal"]
      },
      renews_at: attributes["renews_at"],
      ends_at: attributes["ends_at"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"],
      test_mode: attributes["test_mode"],
      card_brand: attributes["card_brand"],
      card_last_four: attributes["card_last_four"]
    }
  end
end
