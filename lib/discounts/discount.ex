defmodule LemonEx.Discounts.Discount do
  defstruct [
    :id,
    :store_id,
    :name,
    :code,
    :amount,
    :amount_type,
    :is_limited_to_products,
    :is_limited_redemptions,
    :max_redemptions,
    :starts_at,
    :expires_at,
    :duration,
    :duration_in_months,
    :status,
    :status_formatted,
    :created_at,
    :updated_at
  ]

  def from_json(body) do
    attributes = body["attributes"]

    %__MODULE__{
      id: body["id"],
      store_id: attributes["store_id"],
      name: attributes["name"],
      code: attributes["code"],
      amount: attributes["amount"],
      amount_type: attributes["amount_type"],
      is_limited_to_products: attributes["is_limited_to_products"],
      is_limited_redemptions: attributes["is_limited_redemptions"],
      max_redemptions: attributes["max_redemptions"],
      starts_at: attributes["starts_at"],
      expires_at: attributes["expires_at"],
      duration: attributes["duration"],
      duration_in_months: attributes["duration_in_months"],
      status: attributes["status"],
      status_formatted: attributes["status_formatted"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"]
    }
  end
end
