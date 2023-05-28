defmodule LemonEx.Orders.Order do
  defstruct [
    :id,
    :urls,
    :store_id,
    :customer_id,
    :identifier,
    :order_number,
    :user_name,
    :user_email,
    :currency,
    :currency_rate,
    :subtotal,
    :discount_total,
    :tax,
    :total,
    :subtotal_usd,
    :discount_total_usd,
    :tax_usd,
    :total_usd,
    :tax_name,
    :tax_rate,
    :status,
    :status_formatted,
    :refunded,
    :refunded_at,
    :subtotal_formatted,
    :discount_total_formatted,
    :tax_formatted,
    :total_formatted,
    :first_order_item,
    :created_at,
    :updated_at
  ]

  def from_json(body) do
    attributes = body["attributes"]
    first_order_item = attributes["first_order_item"]
    urls = attributes["urls"]

    %__MODULE__{
      id: body["id"],
      urls: %{
        receipt: urls["receipt"]
      },
      store_id: attributes["store_id"],
      customer_id: attributes["customer_id"],
      identifier: attributes["identifier"],
      order_number: attributes["order_number"],
      user_name: attributes["user_name"],
      user_email: attributes["user_email"],
      currency: attributes["currency"],
      currency_rate: attributes["currency_rate"],
      subtotal: attributes["subtotal"],
      discount_total: attributes["discount_total"],
      tax: attributes["tax"],
      total: attributes["total"],
      subtotal_usd: attributes["subtotal_usd"],
      discount_total_usd: attributes["discount_total_usd"],
      tax_usd: attributes["tax_usd"],
      total_usd: attributes["total_usd"],
      tax_name: attributes["tax_name"],
      tax_rate: attributes["tax_rate"],
      status: attributes["status"],
      status_formatted: attributes["status_formatted"],
      refunded: attributes["refunded"],
      refunded_at: attributes["refunded_at"],
      subtotal_formatted: attributes["subtotal_formatted"],
      discount_total_formatted: attributes["discount_total_formatted"],
      tax_formatted: attributes["tax_formatted"],
      total_formatted: attributes["total_formatted"],
      first_order_item: %{
        id: first_order_item["id"],
        order_id: first_order_item["order_id"],
        product_id: first_order_item["product_id"],
        variant_id: first_order_item["variant_id"],
        product_name: first_order_item["product_name"],
        variant_name: first_order_item["variant_name"],
        price: first_order_item["price"],
        created_at: first_order_item["created_at"],
        updated_at: first_order_item["updated_at"],
        test_mode: first_order_item["test_mode"]
      },
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"]
    }
  end
end
