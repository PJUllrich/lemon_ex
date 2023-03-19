defmodule LemonEx.PaginatedResponse do
  defstruct [
    :meta,
    :links,
    :data
  ]

  def from_json(body, data_module) do
    page = body["meta"]["page"]
    links = body["links"]
    data = Enum.map(body["data"], fn item -> data_module.from_json(item) end)

    %__MODULE__{
      meta: %{
        page: %{
          current_page: page["current_page"],
          last_page: page["last_page"],
          from: page["from"],
          to: page["to"],
          per_page: page["per_page"],
          total: page["total"]
        }
      },
      links: %{
        first: links["first"],
        last: links["last"],
        next: links["next"],
        prev: links["prev"]
      },
      data: data
    }
  end
end
