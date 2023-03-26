defmodule Support.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Plug.Test
      import Support.Fixtures
      import Support.ConnCase

      # The default endpoint for testing
      @endpoint Support.Endpoint
    end
  end

  def gen_signature(payload) do
    code = :crypto.mac(:hmac, :sha256, secret(), payload)
    Base.encode16(code, case: :lower)
  end

  defp secret(), do: Application.get_env(:lemon_ex, :webhook_secret)
end
