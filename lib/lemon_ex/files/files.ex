defmodule LemonEx.Files do
  alias LemonEx.Files.File
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/files/#{id}") do
      {:ok, File.from_json(body)}
    end
  end

  def list() do
    with {:ok, body} <- Request.get("/files") do
      {:ok, PaginatedResponse.from_json(body, File)}
    end
  end
end
