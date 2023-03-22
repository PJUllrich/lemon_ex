defmodule LemonEx.Checkouts.CheckoutOptions do
  defstruct [
    :embed,
    :media,
    :logo,
    :desc,
    :discount,
    :dark,
    :subscription_preview,
    :button_color
  ]

  def from_json(body) do
    %__MODULE__{
      embed: body["embed"],
      media: body["media"],
      logo: body["logo"],
      desc: body["desc"],
      discount: body["discount"],
      dark: body["dark"],
      subscription_preview: body["subscription_preview"],
      button_color: body["button_color"]
    }
  end
end
