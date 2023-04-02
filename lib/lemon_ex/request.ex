defmodule LemonEx.Request do
  @api_base_url "https://api.lemonsqueezy.com/v1"

  @spec post(binary(), any()) :: {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def post(url, payload) do
    headers = get_headers()
    url = "#{@api_base_url}#{url}"
    payload = prepare_payload(payload)
    response = HTTPoison.post(url, payload, headers)
    handle_response(response)
  end

  @spec get(binary(), keyword()) :: {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def get(url, params \\ []) do
    headers = get_headers()
    url = "#{@api_base_url}#{url}"
    filter = prepare_filter(params)
    response = HTTPoison.get(url, headers, params: filter)
    handle_response(response)
  end

  @spec patch(binary(), any()) :: {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def patch(url, payload) do
    headers = get_headers()
    url = "#{@api_base_url}#{url}"
    payload = prepare_payload(payload)
    response = HTTPoison.patch(url, payload, headers)
    handle_response(response)
  end

  @spec delete(binary()) :: :ok | {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def delete(url) do
    headers = get_headers()
    url = "#{@api_base_url}#{url}"
    response = HTTPoison.delete(url, headers)
    handle_response(response)
  end

  defp api_key do
    Application.get_env(:lemon_ex, :api_key, "")
  end

  defp get_headers do
    [
      {"Authorization", "Bearer #{api_key()}"},
      {"Accept", "application/vnd.api+json"},
      {"Content-Type", "application/vnd.api+json"}
    ]
  end

  defp prepare_payload(payload) when is_binary(payload), do: payload

  defp prepare_payload(payload) do
    Jason.encode!(payload)
  end

  defp prepare_filter([]), do: []

  defp prepare_filter(params) do
    Enum.reduce(params, %{}, fn {key, value}, acc ->
      Map.put(acc, "filter[#{key}]", value)
    end)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: status_code, body: body}})
       when status_code in [200, 201] do
    Jason.decode(body)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 204, body: _body}}) do
    :ok
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: status_code, body: body}}) do
    with {:ok, body} <- Jason.decode(body) do
      {:error, status_code, body}
    end
  end

  defp handle_response({:error, %HTTPoison.Error{} = error}) do
    {:error, error}
  end
end
