# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :app,
  ecto_repos: [App.Repo]

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OGByntRfizMy+IxNQCawCe7yvJ7SbEHWIQcHH/qsZI6Ml0GjekRRA4EJvLDvzT4k",
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: App.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# Guardian config
config :app, App.Authentication.Guardian,
  issuer: "app",
  secret_key: "+T8mLrwmluUJvldUggEFk8xCMp9G3O/r1wRotc+fLS8GsIs6P4IfqffHoiWf3Y4G"
