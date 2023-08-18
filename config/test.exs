import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :bestnowelixirmysql, Bestnowelixirmysql.Repo,
  username: "root",
  password: "",
  database: "bestnowelixirmysql_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bestnowelixirmysql, BestnowelixirmysqlWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "rYKIqpNJUC6zBk2Wf3DbD4vVG8o1eG+nitKa/sn1iQaUvXiCr94CydOLpfcSXoBo",
  server: false

# In test we don't send emails.
config :bestnowelixirmysql, Bestnowelixirmysql.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :at_ex,
  api_key: "415a70ee214ada0b735eb5220710732037345975777912560acc2237a5bfdc0d",
  username: "B_Best",
  from: "B_U",
  # When changed to "false" one will use the live endpoint url
  sandbox: false
