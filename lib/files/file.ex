defmodule LemonEx.Files.File do
  defstruct [
    :id,
    :variant_id,
    :identifier,
    :name,
    :extension,
    :download_url,
    :size,
    :size_formatted,
    :version,
    :sort,
    :status,
    :created_at,
    :updated_at
  ]

  def from_json(body) do
    attributes = body["attributes"]

    %{
      id: body["id"],
      variant_id: attributes["variant_id"],
      identifier: attributes["identifier"],
      name: attributes["name"],
      extension: attributes["extension"],
      download_url: attributes["download_url"],
      size: attributes["size"],
      size_formatted: attributes["size_formatted"],
      version: attributes["version"],
      sort: attributes["sort"],
      status: attributes["status"],
      created_at: attributes["createdAt"],
      updated_at: attributes["updatedAt"]
    }
  end
end
