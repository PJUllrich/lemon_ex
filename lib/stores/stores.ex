defmodule LemonEx.Stores do
  alias LemonEx.Stores.Store
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/stores/#{id}") do
      {:ok, Store.from_json(body)}
    end
  end

  def list() do
    with {:ok, body} <- Request.get("/stores") do
      {:ok, PaginatedResponse.from_json(body, Store)}
    end
  end
end
