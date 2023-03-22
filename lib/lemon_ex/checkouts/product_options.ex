defmodule LemonEx.Checkouts.ProductOptions do
  defstruct [
    :name,
    :description,
    :media,
    :redirect_url,
    :receipt_button_text,
    :receipt_link_url,
    :receipt_thank_you_note,
    :enabled_variants
  ]

  def from_json(body) do
    %__MODULE__{
      name: body["name"],
      description: body["description"],
      media: body["media"],
      redirect_url: body["redirect_url"],
      receipt_button_text: body["receipt_button_text"],
      receipt_link_url: body["receipt_link_url"],
      receipt_thank_you_note: body["receipt_thank_you_note"],
      enabled_variants: body["enabled_variants"]
    }
  end
end
