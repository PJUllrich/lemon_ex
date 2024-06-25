defmodule LemonEx.LicenseKeys do
  alias LemonEx.LicenseKeys.LicenseKey
  alias LemonEx.Request
  alias LemonEx.PaginatedResponse

  def get(id, opts \\ []) do
    with {:ok, %{"data" => body}} <- Request.get("/license-keys/#{id}", opts) do
      {:ok, LicenseKey.from_json(body)}
    end
  end

  def list(filter \\ [], opts \\ []) do
    with {:ok, body} <- Request.get("/license-keys", filter, opts) do
      {:ok, PaginatedResponse.from_json(body, LicenseKey)}
    end
  end
end
