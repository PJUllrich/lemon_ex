defmodule LemonEx.Subscriptions do
  alias LemonEx.Subscriptions.Subscription
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/subscriptions/#{id}") do
      {:ok, Subscription.from_json(body)}
    end
  end

  def list(filter \\ []) do
    with {:ok, body} <- Request.get("/subscriptions", filter) do
      {:ok, PaginatedResponse.from_json(body, Subscription)}
    end
  end

  def update(id, data) do
    data = Map.merge(%{type: "subscriptions", id: to_string(id)}, data)
    payload = %{data: data}

    with {:ok, %{"data" => body}} <- Request.patch("/subscriptions/#{id}", payload) do
      {:ok, Subscription.from_json(body)}
    end
  end

  def cancel(id) do
    with {:ok, %{"data" => body}} <- Request.delete("/subscriptions/#{id}") do
      {:ok, Subscription.from_json(body)}
    end
  end
end
