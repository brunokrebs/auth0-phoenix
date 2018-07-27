defmodule AppWeb.MemberController do
  use AppWeb, :controller

  alias App.Accounts
  alias App.Accounts.Member

  action_fallback(AppWeb.FallbackController)

  def index(conn, _params) do
    members = Accounts.list_members()
    render(conn, "index.json", members: members)
  end

  def create(conn, %{"member" => member_params}) do
    with {:ok, %Member{} = member} <- Accounts.create_member(member_params) do
      AppWeb.MemberChannel.broadcast_new_user(member)

      conn
      |> put_status(:created)
      |> put_resp_header("location", member_path(conn, :show, member))
      |> render("show.json", member: member)
    end
  end

  def show(conn, %{"id" => id}) do
    member = Accounts.get_member!(id)
    render(conn, "show.json", member: member)
  end

  def update(conn, %{"id" => id, "member" => member_params}) do
    member = Accounts.get_member!(id)

    with {:ok, %Member{} = member} <- Accounts.update_member(member, member_params) do
      AppWeb.MemberChannel.broadcast_updated_user(member)

      render(conn, "show.json", member: member)
    end
  end

  def delete(conn, %{"id" => id}) do
    member = Accounts.get_member!(id)

    with {:ok, %Member{}} <- Accounts.delete_member(member) do
      send_resp(conn, :no_content, "")
    end
  end
end
