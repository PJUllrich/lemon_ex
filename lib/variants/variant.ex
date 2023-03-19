defmodule LemonEx.Variants.Variant do
  defstruct [
    :id,
    :product_id,
    :name,
    :slug,
    :description,
    :price,
    :is_subscription,
    :interval,
    :interval_count,
    :has_free_trial,
    :trial_interval,
    :trial_interval_count,
    :pay_what_you_want,
    :min_price,
    :suggested_price,
    :has_license_keys,
    :license_activation_limit,
    :is_license_limit_unlimited,
    :license_length_value,
    :license_length_unit,
    :is_license_length_unlimited,
    :sort,
    :status,
    :status_formatted,
    :created_at,
    :updated_at
  ]

  def from_json(body) do
    attributes = body["attributes"]

    %__MODULE__{
      id: body["id"],
      product_id: attributes["product_id"],
      name: attributes["name"],
      slug: attributes["slug"],
      description: attributes["description"],
      price: attributes["price"],
      is_subscription: attributes["is_subscription"],
      interval: attributes["interval"],
      interval_count: attributes["interval_count"],
      has_free_trial: attributes["has_free_trial"],
      trial_interval: attributes["trial_interval"],
      trial_interval_count: attributes["trial_interval_count"],
      pay_what_you_want: attributes["pay_what_you_want"],
      min_price: attributes["min_price"],
      suggested_price: attributes["suggested_price"],
      has_license_keys: attributes["has_license_keys"],
      license_activation_limit: attributes["license_activation_limit"],
      is_license_limit_unlimited: attributes["is_license_limit_unlimited"],
      license_length_value: attributes["license_length_value"],
      license_length_unit: attributes["license_length_unit"],
      is_license_length_unlimited: attributes["is_license_length_unlimited"],
      sort: attributes["sort"],
      status: attributes["status"],
      status_formatted: attributes["status_formatted"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"]
    }
  end
end
