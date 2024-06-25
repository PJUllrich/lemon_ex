defmodule LemonEx.Variants do
  alias LemonEx.Variants.Variant
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/variants/#{id}", opts) do
      {:ok, Variant.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/variants", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, Variant)}
    end
  end
end
