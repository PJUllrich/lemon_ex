defmodule LemonEx.DiscountRedemptions.DiscountRedemption do
  defstruct [
    :id,
    :attributes,
    :discount_id,
    :order_id,
    :discount_name,
    :discount_code,
    :discount_amount,
    :discount_amount_type,
    :amount,
    :created_at,
    :updated_at
  ]

  def from_json(body) do
    attributes = body["attributes"]

    %__MODULE__{
      id: body["id"],
      discount_id: attributes["discount_id"],
      order_id: attributes["order_id"],
      discount_name: attributes["discount_name"],
      discount_code: attributes["discount_code"],
      discount_amount: attributes["discount_amount"],
      discount_amount_type: attributes["discount_amount_type"],
      amount: attributes["amount"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"]
    }
  end
end
