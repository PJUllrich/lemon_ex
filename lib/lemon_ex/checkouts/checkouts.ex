defmodule LemonEx.Checkouts do
  alias LemonEx.Checkouts.Checkout
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def create(store_id, variant_id, attributes, opts \\ []) do
    data = %{
      type: "checkouts",
      attributes: attributes,
      relationships: %{
        store: %{
          data: %{
            type: "stores",
            id: to_string(store_id)
          }
        },
        variant: %{
          data: %{
            type: "variants",
            id: to_string(variant_id)
          }
        }
      }
    }

    payload = %{data: data}

    with {:ok, %{"data" => body}} <- Request.post("/checkouts", payload, opts) do
      {:ok, Checkout.from_json(body)}
    end
  end

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/checkouts/#{id}", opts) do
      {:ok, Checkout.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/checkouts", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, Checkout)}
    end
  end
end
