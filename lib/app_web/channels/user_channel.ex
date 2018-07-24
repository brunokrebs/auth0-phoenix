defmodule AppWeb.UserChannel do
  use AppWeb, :channel

  alias App.Accounts

  def join("users", _params, socket) do
    {:ok, "channel: users::joined", socket}
  end

  def broadcast_change(user) do
    response = %{
      user: Phoenix.View.render_one(user, AppWeb.UserView, "user.json")
    }

    AppWeb.Endpoint.broadcast("users", "users::new", response)
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end
end
