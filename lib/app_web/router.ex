defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :protected do
    plug(
      Guardian.Plug.Pipeline,
      otp_app: :app,
      module: App.Authentication.Guardian,
      error_handler: App.AuthErrorHandler
    )

    plug(Guardian.Plug.VerifyHeader, realm: "Bearer")
    plug(Guardian.Plug.EnsureAuthenticated)
    plug(Guardian.Plug.LoadResource)
  end

  scope "/v1", AppWeb do
    pipe_through(:api)

    post("/auth", AuthenticationController, :authenticate)
  end

  scope "/v1", AppWeb do
    pipe_through([:api, :protected])

    resources("/users", UserController)
    resources("/members", MemberController)
  end
end
