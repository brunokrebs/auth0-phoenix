defmodule App.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:password_digest, :string)
    # Virtual fields:
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    # Remove hash, add pw + pw confirmation
    # Remove hash, add pw + pw confirmation
    user
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    # Check that email is valid
    |> validate_required([:name, :email, :password, :password_confirmation])
    # Check that password length is >= 8
    |> validate_format(:email, ~r/@/)
    # Check that password === password_confirmation
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    # Add put_password_digest to changeset pipeline
    |> put_password_digest
  end

  defp put_password_digest(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_digest, hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
