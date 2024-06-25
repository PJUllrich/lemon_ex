defmodule LemonEx.Stores do
  alias LemonEx.Stores.Store
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/stores/#{id}", opts) do
      {:ok, Store.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/stores", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, Store)}
    end
  end
end
