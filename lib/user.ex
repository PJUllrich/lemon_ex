defmodule LemonEx.User do
  alias LemonEx.Schema.User
  alias LemonEx.Request

  def get_authenticated_user do
    with {:ok, body} <- Request.get("/users/me") do
      User.from_json(body)
    end
  end
end
