defmodule LemonEx.LicenseKeys do
  alias LemonEx.LicenseKeys.LicenseKey
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id) do
    with {:ok, %{"data" => body}} <- Request.get("/license-keys/#{id}") do
      {:ok, LicenseKey.from_json(body)}
    end
  end

  def list() do
    with {:ok, body} <- Request.get("/license-keys") do
      {:ok, PaginatedResponse.from_json(body, LicenseKey)}
    end
  end
end
