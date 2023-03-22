defmodule LemonEx.Orders do
  alias LemonEx.Orders.Order
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/orders/#{id}") do
      {:ok, Order.from_json(body)}
    end
  end

  def list() do
    with {:ok, body} <- Request.get("/orders") do
      {:ok, PaginatedResponse.from_json(body, Order)}
    end
  end
end
