defmodule LemonEx.Users do
  alias LemonEx.Users.User
  alias LemonEx.Request

  def get_authenticated_user do
    with {:ok, body} <- Request.get("/users/me") do
      {:ok, User.from_json(body)}
    end
  end
end
