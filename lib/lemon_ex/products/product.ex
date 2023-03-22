defmodule LemonEx.Products.Product do
  defstruct [
    :id,
    :store_id,
    :name,
    :slug,
    :description,
    :status,
    :status_formatted,
    :thumb_url,
    :large_thumb_url,
    :price,
    :pay_what_you_want,
    :from_price,
    :to_price,
    :buy_now_url,
    :price_formatted,
    :created_at,
    :updated_at
  ]

  def from_json(body) do
    attributes = body["attributes"]

    %__MODULE__{
      id: body["id"],
      store_id: attributes["store_id"],
      name: attributes["name"],
      slug: attributes["slug"],
      description: attributes["description"],
      status: attributes["status"],
      status_formatted: attributes["status_formatted"],
      thumb_url: attributes["thumb_url"],
      large_thumb_url: attributes["large_thumb_url"],
      price: attributes["price"],
      pay_what_you_want: attributes["pay_what_you_want"],
      from_price: attributes["from_price"],
      to_price: attributes["to_price"],
      buy_now_url: attributes["buy_now_url"],
      price_formatted: attributes["price_formatted"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"]
    }
  end
end
