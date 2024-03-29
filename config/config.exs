# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :currency_convertex_api,
  ecto_repos: [CurrencyConvertexApi.Repo]

config :currency_convertex_api, CurrencyConvertexApi.Repo,
  migration_timestamps: [
    type: :utc_datetime
  ]

# Auth
config :currency_convertex_api, CurrencyConvertexApiWeb.Auth.Guardian,
  issuer: "currency_convertex_api",
  secret_key: "qQmvemACVfNgpAvdJ+moCdl5VNO7OeS4EWpb/Xo5lOXKQtTmN7HYCl2DoXzcwPGc"

# Auth Pipeline
config :currency_convertex_api, CurrencyConvertexApiWeb.Auth.Pipeline,
  module: CurrencyConvertexApiWeb.Auth.Guardian,
  error_handler: CurrencyConvertexApiWeb.Auth.ErrorHandler

config :currency_convertex_api, Oban,
  repo: CurrencyConvertexApi.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10]

# Configures the endpoint
config :currency_convertex_api, CurrencyConvertexApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CurrencyConvertexApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CurrencyConvertexApi.PubSub,
  live_view: [signing_salt: "JVh4GVLc"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :currency_convertex_api, CurrencyConvertexApi.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
