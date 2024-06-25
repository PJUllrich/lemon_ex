defmodule LemonEx.Files do
  alias LemonEx.Files.File
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/files/#{id}", opts) do
      {:ok, File.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/files", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, File)}
    end
  end
end
