defmodule LemonEx.SubscriptionInvoices do
  alias LemonEx.SubscriptionInvoices.SubscriptionInvoice
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/subscription-invoices/#{id}") do
      {:ok, SubscriptionInvoice.from_json(body)}
    end
  end

  def list() do
    with {:ok, body} <- Request.get("/subscription-invoices") do
      {:ok, PaginatedResponse.from_json(body, SubscriptionInvoice)}
    end
  end
end
