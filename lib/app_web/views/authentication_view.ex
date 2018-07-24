defmodule AppWeb.AuthenticationView do
  use AppWeb, :view
  alias AppWeb.AuthenticationView

  def render("token.json", %{token: token}) do
    %{auth_token: token}
  end
end
