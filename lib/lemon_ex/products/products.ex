defmodule LemonEx.Products do
  alias LemonEx.Products.Product
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/products/#{id}") do
      {:ok, Product.from_json(body)}
    end
  end

  def list() do
    with {:ok, body} <- Request.get("/products") do
      {:ok, PaginatedResponse.from_json(body, Product)}
    end
  end
end
