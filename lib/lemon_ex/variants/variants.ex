defmodule LemonEx.Variants do
  alias LemonEx.Variants.Variant
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/variants/#{id}") do
      {:ok, Variant.from_json(body)}
    end
  end

  def list(filter \\ []) do
    with {:ok, body} <- Request.get("/variants", filter) do
      {:ok, PaginatedResponse.from_json(body, Variant)}
    end
  end
end
