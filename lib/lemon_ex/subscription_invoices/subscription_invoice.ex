defmodule LemonEx.SubscriptionInvoices.SubscriptionInvoice do
  defstruct [
    :id,
    :store_id,
    :subscription_id,
    :billing_reason,
    :card_brand,
    :card_last_four,
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
    :status,
    :status_formatted,
    :refunded,
    :refunded_at,
    :subtotal_formatted,
    :discount_total_formatted,
    :tax_formatted,
    :total_formatted,
    :urls,
    :created_at,
    :updated_at,
    :test_mode
  ]

  def from_json(body) do
    attributes = body["attributes"]
    urls = attributes["urls"]

    %__MODULE__{
      id: body["id"],
      store_id: attributes["store_id"],
      subscription_id: attributes["subscription_id"],
      billing_reason: attributes["billing_reason"],
      card_brand: attributes["card_brand"],
      card_last_four: attributes["card_last_four"],
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
      status: attributes["status"],
      status_formatted: attributes["status_formatted"],
      refunded: attributes["refunded"],
      refunded_at: attributes["refunded_at"],
      subtotal_formatted: attributes["subtotal_formatted"],
      discount_total_formatted: attributes["discount_total_formatted"],
      tax_formatted: attributes["tax_formatted"],
      total_formatted: attributes["total_formatted"],
      urls: %{
        invoice_url: urls["invoice_url"]
      },
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"],
      test_mode: attributes["test_mode"]
    }
  end
end
