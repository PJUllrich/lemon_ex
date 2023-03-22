defmodule LemonEx.Checkouts.CheckoutData do
  defstruct [
    :email,
    :name,
    :billing_address,
    :tax_number,
    :discount_code,
    :custom
  ]

  def from_json(body) do
    billing_address = body["billing_address"]
    country = if billing_address != [], do: billing_address["country"]
    zip = if billing_address != [], do: billing_address["zip"]

    %__MODULE__{
      email: body["email"],
      name: body["name"],
      billing_address: %{
        country: country,
        zip: zip
      },
      tax_number: body["tax_number"],
      discount_code: body["discount_code"],
      custom: body["custom"]
    }
  end
end
