defmodule LemonEx.LicenseKeys.LicenseKey do
  defstruct [
    :id,
    :store_id,
    :customer_id,
    :order_id,
    :order_item_id,
    :product_id,
    :user_name,
    :user_email,
    :key,
    :key_short,
    :activation_limit,
    :instances_count,
    :disabled,
    :status,
    :status_formatted,
    :expires_at,
    :created_at,
    :updated_at
  ]

  def from_json(body) do
    attributes = body["attributes"]

    %__MODULE__{
      id: body["id"],
      store_id: attributes["store_id"],
      customer_id: attributes["customer_id"],
      order_id: attributes["order_id"],
      order_item_id: attributes["order_item_id"],
      product_id: attributes["product_id"],
      user_name: attributes["user_name"],
      user_email: attributes["user_email"],
      key: attributes["key"],
      key_short: attributes["key_short"],
      activation_limit: attributes["activation_limit"],
      instances_count: attributes["instances_count"],
      disabled: attributes["disabled"],
      status: attributes["status"],
      status_formatted: attributes["status_formatted"],
      expires_at: attributes["expires_at"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"]
    }
  end
end
