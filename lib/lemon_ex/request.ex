defmodule LemonEx.Request do
  @api_base_url "https://api.lemonsqueezy.com/v1"

  @spec post(binary(), any()) :: {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def post(url, payload) when is_binary(payload) do
    headers = get_headers()
    url = "#{@api_base_url}#{url}"
    response = HTTPoison.post(url, payload, headers)
    handle_response(response)
  end

  def post(url, payload) do
    with {:ok, payload} <- Jason.encode(payload) do
      post(url, payload)
    end
  end

  @spec get(binary()) :: {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def get(url) do
    headers = get_headers()
    url = "#{@api_base_url}#{url}"
    response = HTTPoison.get(url, headers)
    handle_response(response)
  end

  @spec patch(binary(), any()) :: {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def patch(url, payload) when is_binary(payload) do
    headers = get_headers()
    url = "#{@api_base_url}#{url}"
    response = HTTPoison.patch(url, payload, headers)
    handle_response(response)
  end

  def patch(url, payload) do
    with {:ok, payload} <- Jason.encode(payload) do
      patch(url, payload)
    end
  end

  @spec delete(binary()) :: :ok | {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def delete(url) do
    headers = get_headers()
    url = "#{@api_base_url}#{url}"
    response = HTTPoison.delete(url, headers)
    handle_response(response)
  end

  defp api_key do
    Application.get_env(:lemon_ex, :api_key)
  end

  defp get_headers do
    [
      {"Authorization", "Bearer #{api_key()}"},
      {"Accept", "application/vnd.api+json"},
      {"Content-Type", "application/vnd.api+json"}
    ]
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Jason.decode(body)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 204, body: body}}) do
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

  defp decode_body("" = _body), do: {:ok, nil}

  defp decode_body(body), do: Jason.decode(body)
end
