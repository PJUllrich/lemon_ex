defmodule LemonEx.Products do
  alias LemonEx.Products.Product
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/products/#{id}", opts) do
      {:ok, Product.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/products", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, Product)}
    end
  end
end
