defmodule LemonEx.Customers do
  alias LemonEx.Customers.Customer
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/customers/#{id}", opts) do
      {:ok, Customer.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/customers", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, Customer)}
    end
  end
end
