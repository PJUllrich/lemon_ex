defmodule LemonEx.Users do
  alias LemonEx.Users.User
  alias LemonEx.Request

  def get_authenticated_user(opts \\ []) do
    with {:ok, body} <- Request.get("/users/me", opts) do
      {:ok, User.from_json(body)}
    end
  end
end
