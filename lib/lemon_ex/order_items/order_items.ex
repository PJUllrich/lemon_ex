defmodule LemonEx.OrderItems do
  alias LemonEx.OrderItems.OrderItem
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/order-items/#{id}", opts) do
      {:ok, OrderItem.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/order-items", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, OrderItem)}
    end
  end
end
