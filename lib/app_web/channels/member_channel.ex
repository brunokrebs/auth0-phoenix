defmodule AppWeb.MemberChannel do
  use AppWeb, :channel

  def join("members", _params, socket) do
    {:ok, "channel: members::joined", socket}
  end

  def broadcast_new_user(member) do
    response = %{
      member: Phoenix.View.render_one(member, AppWeb.MemberView, "member.json")
    }

    AppWeb.Endpoint.broadcast("members", "members::new", response)
  end

  def broadcast_updated_user(member) do
    response = %{
      member: Phoenix.View.render_one(member, AppWeb.MemberView, "member.json")
    }

    AppWeb.Endpoint.broadcast("members", "member::update", response)
  end

  def terminate(_reason, socket) do
    {:ok, socket}
  end
end
