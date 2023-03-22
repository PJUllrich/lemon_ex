defmodule LemonEx.Stores.Store do
  defstruct [
    :id,
    :name,
    :slug,
    :domain,
    :url,
    :avatar_url,
    :plan,
    :country,
    :country_nicename,
    :currency,
    :total_sales,
    :total_revenue,
    :thirty_day_sales,
    :thirty_day_revenue,
    :created_at,
    :updated_at
  ]

  def from_json(map) do
    attributes = map["attributes"]

    %__MODULE__{
      id: map["id"],
      name: attributes["name"],
      slug: attributes["slug"],
      domain: attributes["domain"],
      url: attributes["url"],
      avatar_url: attributes["avatar_url"],
      plan: attributes["plan"],
      country: attributes["country"],
      country_nicename: attributes["country_nicename"],
      currency: attributes["currency"],
      total_sales: attributes["total_sales"],
      total_revenue: attributes["total_revenue"],
      thirty_day_sales: attributes["thirty_day_sales"],
      thirty_day_revenue: attributes["thirty_day_revenue"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"]
    }
  end
end
