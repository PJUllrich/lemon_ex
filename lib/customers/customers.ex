defmodule LemonEx.Customers do
  alias LemonEx.Customers.Customer
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/customers/#{id}") do
      {:ok, Customer.from_json(body)}
    end
  end

  def list() do
    with {:ok, body} <- Request.get("/customers") do
      {:ok, PaginatedResponse.from_json(body, Customer)}
    end
  end
end
