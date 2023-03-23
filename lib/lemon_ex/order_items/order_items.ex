defmodule LemonEx.OrderItems do
  alias LemonEx.OrderItems.OrderItem
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/order-items/#{id}") do
      {:ok, OrderItem.from_json(body)}
    end
  end

  def list(filter \\ []) do
    with {:ok, body} <- Request.get("/order-items", filter) do
      {:ok, PaginatedResponse.from_json(body, OrderItem)}
    end
  end
end
