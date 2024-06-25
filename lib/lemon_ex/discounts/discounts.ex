defmodule LemonEx.Discounts do
  alias LemonEx.Discounts.Discount
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def create(store_id, attributes, opts \\ []) do
    data = %{
      type: "discounts",
      attributes: attributes,
      relationships: %{
        store: %{
          data: %{
            type: "stores",
            id: to_string(store_id)
          }
        }
      }
    }

    payload = %{data: data}

    with {:ok, %{"data" => body}} <- Request.post("/discounts", payload, opts) do
      {:ok, Discount.from_json(body)}
    end
  end

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/discounts/#{id}", opts) do
      {:ok, Discount.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/discounts", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, Discount)}
    end
  end

  def update(id, data, opts \\ []) do
    data = Map.merge(%{type: "discounts", id: to_string(id)}, data)
    payload = %{data: data}

    with {:ok, %{"data" => body}} <- Request.patch("/discounts/#{id}", payload, opts) do
      {:ok, Discount.from_json(body)}
    end
  end

  @spec delete(any()) :: :ok | {:error, integer(), any()} | {:error, any()}
  def delete(id, opts \\ []) do
    Request.delete("/discounts/#{id}", opts)
  end
end
