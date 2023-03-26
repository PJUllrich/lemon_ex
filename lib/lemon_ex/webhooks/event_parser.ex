defmodule LemonEx.Webhooks.EventParser do
  @moduledoc """

  """

  import Plug.Conn

  alias LemonEx.Webhooks.CacheRawBodyPlug

  @spec parse(Plug.Conn.t(), map()) :: {:ok, map()} | {:error, integer(), binary()}
  def parse(%Plug.Conn{} = conn, _payload) do
    with {:ok, signature} <- get_x_signature(conn),
         :ok <- verify_header(conn, signature) do
      :ok
    end
  end

  defp get_x_signature(conn) do
    case get_req_header(conn, "x-signature") do
      [signature] -> {:ok, signature}
      [] -> {:error, 400, "X-Signature missing."}
    end
  end

  defp verify_header(conn, signature) do
    raw_body = CacheRawBodyPlug.get_raw_body!(conn)
    secret = get_secret!()
    hash = hash_raw_body(raw_body, secret)

    # Prevent timing attacks by using byte-wise comparison.
    # Context: https://codahale.com/a-lesson-in-timing-attacks
    if Plug.Crypto.secure_compare(hash, signature) do
      :ok
    else
      {:error, 400, "Signature and Payload Hash unequal."}
    end
  end

  defp get_secret!() do
    Application.get_env(:lemon_ex, :webhook_secret) ||
      raise """
      The LemonSqueezy Webhook Secret is missing.

      You can set it like this in e.g. your runtime.exs:

      config :lemon_ex, webhook_secret: "your-webhook-secret-here"

      """
  end

  defp hash_raw_body(raw_body, secret) do
    :crypto.mac(:hmac, :sha256, secret, raw_body)
    |> Base.encode16()
    |> String.downcase()
  end
end
