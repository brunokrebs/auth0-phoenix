use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :app, AppWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
# tell logger to load a LoggerFileBackend processes
config :logger,
  backends: [{LoggerFileBackend, :error_log}],
  format: "[$level] $message\n"

# configuration for the {LoggerFileBackend, :error_log} backend
config :logger, :error_log,
  path: "./log/development.log",
  level: :debug

# Configure your database
config :app, App.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "",
  database: "app_test",
  hostname: "auth0.phoenix.postgres.db",
  pool: Ecto.Adapters.SQL.Sandbox
