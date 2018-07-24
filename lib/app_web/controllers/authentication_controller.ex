defmodule AppWeb.AuthenticationController do
  use AppWeb, :controller

  alias App.Accounts
  alias App.Accounts.User
  alias App.Authentication.Guardian
  alias App.Authentication.AuthenticateExistingUser

  action_fallback(AppWeb.FallbackController)

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case AuthenticateExistingUser.sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("token.json", token: token)

      _ ->
        {:error, :unauthorized}
    end
  end

  def sign_up(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("token.json", token: token)
    end
  end
end
