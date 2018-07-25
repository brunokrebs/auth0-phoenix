defmodule AppWeb.AuthenticationView do
  use AppWeb, :view

  def render("token.json", %{token: token}) do
    %{auth_token: token}
  end
end
