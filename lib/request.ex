defmodule LemonEx.Request do
  alias LemonEx.LemonSqueezy.User

  @api_base_url "https://api.lemonsqueezy.com/v1"

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

  def get(url) do
    headers = get_headers()
    url = "#{@api_base_url}#{url}"
    response = HTTPoison.get(url, headers)
    handle_response(response)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    Jason.decode(body)
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: _, body: body}}) do
    {:error, "Something went wrong: #{body}"}
  end

  defp handle_response({:error, %HTTPoison.Error{} = error}) do
    {:error, "Request error: #{inspect(error)}"}
  end
end
