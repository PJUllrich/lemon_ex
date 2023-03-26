defmodule LemonEx.Webhooks.Event do
  @moduledoc """
  An event received by the Webhook.
  """

  require Logger

  alias LemonEx.LicenseKeys.LicenseKey
  alias LemonEx.Orders.Order
  alias LemonEx.SubscriptionInvoices.SubscriptionInvoice
  alias LemonEx.Subscriptions.Subscription

  defstruct [
    :name,
    :meta,
    :data
  ]

  def from_json(body) do
    name = get_in(body, ["meta", "event_name"])
    type = get_in(body, ["data", "type"])
    object = parse_data(type, body["data"])

    %__MODULE__{
      name: name,
      meta: body["meta"],
      data: object
    }
  end

  defp parse_data("orders", data), do: Order.from_json(data)
  defp parse_data("subscriptions", data), do: Subscription.from_json(data)
  defp parse_data("subscription-invoices", data), do: SubscriptionInvoice.from_json(data)
  defp parse_data("license-keys", data), do: LicenseKey.from_json(data)

  defp parse_data(type, data) do
    Logger.warn("LemonEx: Unknown webhook event type #{type}")
    data
  end
end
