defmodule LemonEx.Subscriptions do
  alias LemonEx.Subscriptions.Subscription
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/subscriptions/#{id}", opts) do
      {:ok, Subscription.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/subscriptions", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, Subscription)}
    end
  end

  def update(id, data, opts \\ []) do
    data = Map.merge(%{type: "subscriptions", id: to_string(id)}, data)
    payload = %{data: data}

    with {:ok, %{"data" => body}} <- Request.patch("/subscriptions/#{id}", payload, opts) do
      {:ok, Subscription.from_json(body)}
    end
  end

  def cancel(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.delete("/subscriptions/#{id}", opts) do
      {:ok, Subscription.from_json(body)}
    end
  end
end
