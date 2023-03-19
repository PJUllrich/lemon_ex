defmodule LemonEx.User do
  defstruct [
    :id,
    :name,
    :email,
    :color,
    :avatar_url,
    :has_custom_avatar,
    :created_at,
    :updated_at
  ]

  def from_json(json) do
    %{
      "type" => _,
      "id" => id,
      "attributes" => attributes,
      "links" => _
    } = json["data"]

    %__MODULE__{
      id: id,
      name: attributes["name"],
      email: attributes["email"],
      color: attributes["color"],
      avatar_url: attributes["avatar_url"],
      has_custom_avatar: attributes["has_custom_avatar"],
      created_at: attributes["created_at"],
      updated_at: attributes["updated_at"]
    }
  end
end
