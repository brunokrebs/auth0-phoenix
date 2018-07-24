defmodule App.Authentication.AuthenticateExistingUser do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias App.Repo
  alias App.Accounts.User
  alias App.Authentication.Guardian

  def sign_in(email, password) do
    case authenticate(email, password) do
      {:ok, user} ->
        Guardian.encode_and_sign(user)

      _ ->
        {:error, :unauthorized}
    end
  end

  defp authenticate(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
         do: verify_password(password, user)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        dummy_checkpw()
        {:error, "Login error."}

      user ->
        {:ok, user}
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if checkpw(password, user.password_digest) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end
end
