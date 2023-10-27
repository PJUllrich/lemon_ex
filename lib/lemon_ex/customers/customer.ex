defmodule LemonEx.Customers.Customer do
  defstruct [
    :id,
    :store_id,
    :name,
    :email,
    :status,
    :city,
    :region,
    :country,
    :total_revenue_currency,
    :mrr,
    :status_formatted,
    :country_formatted,
    :total_revenue_currency_formatted,
    :mrr_formatted,
    :urls,
    :created_at,
    :updated_at,
    :test_mode
  ]

  def from_json(map) do
    attributes = map["attributes"]
    urls = attributes["urls"]

    %__MODULE__{
      id: map["id"],
      store_id: attributes["store_id"],
      name: attributes["name"],
      email: attributes["email"],
      status: attributes["status"],
      city: attributes["city"],
      region: attributes["region"],
      country: attributes["country"],
      total_revenue_currency: attributes["total_revenue_currency"],
      mrr: attributes["mrr"],
      status_formatted: attributes["status_formatted"],
      country_formatted: attributes["country_formatted"],
      total_revenue_currency_formatted: attributes["total_revenue_currency_formatted"],
      mrr_formatted: attributes["mrr_formatted"],
      urls: %{
        customer_portal: urls["customer_portal"]
      },
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"],
      test_mode: attributes["test_mode"]
    }
  end
end
