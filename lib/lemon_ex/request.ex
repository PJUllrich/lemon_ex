defmodule LemonEx.Request do
  @api_base_url "https://api.lemonsqueezy.com/v1"

  @spec post(binary(), any(), keyword()) ::
          {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def post(url, payload, opts \\ []) do
    headers = get_headers(opts)
    url = "#{@api_base_url}#{url}"
    payload = prepare_payload(payload)
    opts = request_options()
    response = HTTPoison.post(url, payload, headers, opts)
    handle_response(response)
  end

  @spec get(binary(), keyword(), keyword()) ::
          {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def get(url, params \\ [], opts \\ []) do
    headers = get_headers(opts)
    url = "#{@api_base_url}#{url}"
    params = prepare_params(params)
    opts = [params: params] ++ request_options()
    response = HTTPoison.get(url, headers, opts)
    handle_response(response)
  end

  @spec patch(binary(), any(), keyword()) ::
          {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def patch(url, payload, opts \\ []) do
    headers = get_headers(opts)
    url = "#{@api_base_url}#{url}"
    payload = prepare_payload(payload)
    opts = request_options()
    response = HTTPoison.patch(url, payload, headers, opts)
    handle_response(response)
  end

  @spec delete(binary(), keyword()) ::
          :ok | {:ok, map()} | {:error, any()} | {:error, integer(), any()}
  def delete(url, opts \\ []) do
    headers = get_headers(opts)
    url = "#{@api_base_url}#{url}"
    opts = request_options()
    response = HTTPoison.delete(url, headers, opts)
    handle_response(response)
  end

  defp api_key do
    Application.get_env(:lemon_ex, :api_key, "")
  end

  defp request_options do
    Application.get_env(:lemon_ex, :request_options, [])
  end

  defp get_headers(opts) do
    bearer_token = Keyword.get(opts, :api_key, api_key())

    [
      {"Authorization", "Bearer #{bearer_token}"},
      {"Accept", "application/vnd.api+json"},
      {"Content-Type", "application/vnd.api+json"}
    ]
  end

  defp prepare_payload(payload) when is_binary(payload), do: payload

  defp prepare_payload(payload) do
    Jason.encode!(payload)
  end

  defp prepare_params([]), do: []

  defp prepare_params(params) do
    {filter, params} = Keyword.pop(params, :filter, [])
    {page, params} = Keyword.pop(params, :page, [])
    filter = build_nested_params(filter, "filter")
    page = build_nested_params(page, "page")
    params |> Map.new() |> Map.merge(filter) |> Map.merge(page)
  end

  defp build_nested_params(params, param_name) do
    Enum.reduce(params, %{}, fn {key, value}, acc ->
      Map.put(acc, "#{param_name}[#{key}]", value)
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
