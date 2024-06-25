defmodule LemonEx.Orders do
  alias LemonEx.Orders.Order
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/orders/#{id}", opts) do
      {:ok, Order.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/orders", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, Order)}
    end
  end
end
