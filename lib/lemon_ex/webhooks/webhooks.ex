defmodule LemonEx.Webhooks do
  @doc """
  Generate a random signing secret with an optional length.
  The length must be between 8 and 40.

  Uses the same logic to generate a random string as Phoenix.
  See: https://github.com/phoenixframework/phoenix/blob/3b9fca11b6a4d6a61ac3ca9163b876e9cdd11dc7/lib/mix/tasks/phoenix.gen.secret.ex#L26
  """
  def gen_signing_secret(length \\ 40)

  def gen_signing_secret(length) when length >= 8 and length <= 40 do
    length |> :crypto.strong_rand_bytes() |> Base.encode64() |> binary_part(0, length)
  end

  def gen_signing_secret(length) do
    raise """
      The webhook secret length has to be between 8 and 40 characters.
      Your specified length was #{length}.
    """
  end
end
