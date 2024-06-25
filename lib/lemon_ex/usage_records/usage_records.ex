defmodule LemonEx.UsageRecords do
  alias LemonEx.UsageRecords.UsageRecord
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def create(subscription_id, attributes, opts \\ []) do
    data = %{
      type: "usage-records",
      attributes: attributes,
      relationships: %{
        subscription_item: %{
          data: %{
            type: "subscription-items",
            id: to_string(subscription_id)
          }
        }
      }
    }

    payload = %{data: data}

    with {:ok, %{"data" => body}} <- Request.post("/usage-records", payload, opts) do
      {:ok, UsageRecord.from_json(body)}
    end
  end

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/usage-records/#{id}", opts) do
      {:ok, UsageRecord.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/usage-records", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, UsageRecord)}
    end
  end
end
