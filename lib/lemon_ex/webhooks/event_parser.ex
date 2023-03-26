defmodule LemonEx.Webhooks.EventParser do
  @moduledoc """

  """

  import Plug.Conn

  alias LemonEx.Webhooks.Event

  @spec parse(Plug.Conn.t()) :: {:ok, map()} | {:error, integer(), binary()}
  def parse(%Plug.Conn{} = conn) do
    with {:ok, signature} <- get_x_signature(conn),
         {:ok, payload} <- verify_payload(conn, signature),
         event <- Event.from_json(payload) do
      {:ok, event}
    end
  end

  defp get_x_signature(conn) do
    case get_req_header(conn, "x-signature") do
      [signature] -> {:ok, signature}
      [] -> {:error, 400, "X-Signature missing."}
    end
  end

  defp verify_payload(conn, signature) do
    {:ok, raw_body, _conn} = read_body(conn)
    secret = get_secret!()
    hash = hash_raw_body(raw_body, secret)

    # Prevent timing attacks by using byte-wise comparison.
    # Context: https://codahale.com/a-lesson-in-timing-attacks
    if Plug.Crypto.secure_compare(hash, signature) do
      {:ok, Jason.decode!(raw_body)}
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
