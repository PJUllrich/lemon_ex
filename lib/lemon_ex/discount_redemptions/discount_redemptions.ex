defmodule LemonEx.DiscountRedemptions do
  alias LemonEx.DiscountRedemptions.DiscountRedemption
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/discount-redemptions/#{id}", opts) do
      {:ok, DiscountRedemption.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/discount-redemptions", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, DiscountRedemption)}
    end
  end
end
