defmodule AppWeb.MemberControllerTest do
  use AppWeb.ConnCase

  alias App.Accounts
  alias App.Accounts.Member

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:member) do
    {:ok, member} = Accounts.create_member(@create_attrs)
    member
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all members", %{conn: conn} do
      conn = get conn, member_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create member" do
    test "renders member when data is valid", %{conn: conn} do
      conn = post conn, member_path(conn, :create), member: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, member_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, member_path(conn, :create), member: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update member" do
    setup [:create_member]

    test "renders member when data is valid", %{conn: conn, member: %Member{id: id} = member} do
      conn = put conn, member_path(conn, :update, member), member: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, member_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, member: member} do
      conn = put conn, member_path(conn, :update, member), member: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete member" do
    setup [:create_member]

    test "deletes chosen member", %{conn: conn, member: member} do
      conn = delete conn, member_path(conn, :delete, member)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, member_path(conn, :show, member)
      end
    end
  end

  defp create_member(_) do
    member = fixture(:member)
    {:ok, member: member}
  end
end
