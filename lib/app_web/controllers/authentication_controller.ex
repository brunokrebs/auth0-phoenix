defmodule AppWeb.AuthenticationController do
  use AppWeb, :controller

  alias App.Authentication.AuthenticateUser

  action_fallback(AppWeb.FallbackController)

  def authenticate(conn, %{"access_token" => access_token}) do
    case AuthenticateUser.authenticate(access_token) do
      {:ok, token, _claims} ->
        conn |> render("token.json", token: token)

      _ ->
        {:error, :unauthorized}
    end
  end
end
