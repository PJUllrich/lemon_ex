defmodule LemonEx.Checkouts.Preview do
  defstruct [
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
    :subtotal_formatted,
    :discount_total_formatted,
    :tax_formatted,
    :total_formatted
  ]

  def from_json(false), do: nil

  def from_json(body) do
    %__MODULE__{
      currency: body["currency"],
      currency_rate: body["currency_rate"],
      subtotal: body["subtotal"],
      discount_total: body["discount_total"],
      tax: body["tax"],
      total: body["total"],
      subtotal_usd: body["subtotal_usd"],
      discount_total_usd: body["discount_total_usd"],
      tax_usd: body["tax_usd"],
      total_usd: body["total_usd"],
      subtotal_formatted: body["subtotal_formatted"],
      discount_total_formatted: body["discount_total_formatted"],
      tax_formatted: body["tax_formatted"],
      total_formatted: body["total_formatted"]
    }
  end
end
