defmodule LemonEx.DiscountRedemptions do
  alias LemonEx.DiscountRedemptions.DiscountRedemption
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/discount-redemptions/#{id}") do
      {:ok, DiscountRedemption.from_json(body)}
    end
  end

  def list() do
    with {:ok, body} <- Request.get("/discount-redemptions") do
      {:ok, PaginatedResponse.from_json(body, DiscountRedemption)}
    end
  end
end
