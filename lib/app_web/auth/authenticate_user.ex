defmodule App.Authentication.AuthenticateUser do
  alias App.Repo
  alias App.Accounts
  alias App.Accounts.User
  alias App.Authentication.Guardian

  def authenticate(access_token) do
    headers = [
      Authorization: "Bearer #{access_token}",
      "Content-Type": Application.get_env(:app, App.Authentication.Auth0)[:content_type]
    ]

    case HTTPoison.get(Application.get_env(:app, App.Authentication.Auth0)[:domain], headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        response = body |> Poison.decode!()
        username = response["sub"]

        case Repo.get_by(User, username: username) do
          nil ->
            with {:ok, %User{} = user} <- Accounts.create_user(%{"username" => username}) do
              Guardian.encode_and_sign(user)
            end

          user ->
            Guardian.encode_and_sign(user)
        end

      {:ok, %HTTPoison.Response{status_code: 401}} ->
        {:error, :unauthorized}
    end
  end
end
