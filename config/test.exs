import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :currency_convertex_api, CurrencyConvertexApi.Repo,
  username: "root",
  password: "root",
  hostname: "localhost",
  database: "playground#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :currency_convertex_api, CurrencyConvertexApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "4J6JP8WbRYHgkdcxVe1H4b1FB3BsSiqAWNAlo2XWlbO9ETuSVYHZTj5Nc1Ljrvbb",
  server: false

# In test we don't send emails.
config :currency_convertex_api, CurrencyConvertexApi.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Mock adapter for all clients
config :tesla, adapter: Tesla.Mock
