defmodule LemonEx.UsageRecords.UsageRecord do
  defstruct [
    :id,
    :type,
    :subscription_item_id,
    :quantity,
    :action,
    :updated_at,
    :created_at
  ]

  def from_json(body) do
    attributes = body["attributes"]

    %__MODULE__{
      id: body["id"],
      type: body["type"],
      subscription_item_id: attributes["subscription_item_id"],
      quantity: attributes["quantity"],
      action: attributes["action"],
      updated_at: attributes["updated_at"],
      created_at: attributes["created_at"]
    }
  end
end
