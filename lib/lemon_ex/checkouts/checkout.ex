defmodule LemonEx.Checkouts.Checkout do
  alias LemonEx.Checkouts.CheckoutData
  alias LemonEx.Checkouts.CheckoutOptions
  alias LemonEx.Checkouts.Preview
  alias LemonEx.Checkouts.ProductOptions

  defstruct [
    :id,
    :store_id,
    :variant_id,
    :custom_price,
    :product_options,
    :checkout_options,
    :checkout_data,
    :preview,
    :expires_at,
    :created_at,
    :updated_at,
    :test_mode,
    :url
  ]

  def from_json(body) do
    attributes = body["attributes"]
    product_options = attributes["product_options"]
    checkout_options = attributes["checkout_options"]
    checkout_data = attributes["checkout_data"]
    preview = attributes["preview"]

    %__MODULE__{
      id: body["id"],
      store_id: attributes["store_id"],
      variant_id: attributes["variant_id"],
      custom_price: attributes["custom_price"],
      product_options: ProductOptions.from_json(product_options),
      checkout_options: CheckoutOptions.from_json(product_options),
      checkout_data: CheckoutData.from_json(checkout_data),
      preview: Preview.from_json(preview),
      expires_at: attributes["expires_at"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"],
      test_mode: attributes["test_mode"],
      url: attributes["url"]
    }
  end
end
