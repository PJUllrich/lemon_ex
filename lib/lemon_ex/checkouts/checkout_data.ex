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

    %__MODULE__{
      email: body["email"],
      name: body["name"],
      billing_address: %{
        country: billing_address["country"],
        zip: billing_address["zip"]
      },
      tax_number: body["tax_number"],
      discount_code: body["discount_code"],
      custom: body["custom"]
    }
  end
end
