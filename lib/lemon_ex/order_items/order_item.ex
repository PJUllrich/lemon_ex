defmodule LemonEx.OrderItems.OrderItem do
  defstruct [
    :id,
    :order_id,
    :product_id,
    :variant_id,
    :product_name,
    :variant_name,
    :price,
    :created_at,
    :updated_at
  ]

  def from_json(body) do
    attributes = body["attributes"]

    %__MODULE__{
      id: body["id"],
      order_id: attributes["order_id"],
      product_id: attributes["product_id"],
      variant_id: attributes["variant_id"],
      product_name: attributes["product_name"],
      variant_name: attributes["variant_name"],
      price: attributes["price"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"]
    }
  end
end
