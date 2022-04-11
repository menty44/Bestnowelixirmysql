# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :bestnowelixirmysql,
  ecto_repos: [Bestnowelixirmysql.Repo]

# Configures the endpoint
config :bestnowelixirmysql, BestnowelixirmysqlWeb.Endpoint,
  url: [host: "0.0.0.0"],
  render_errors: [view: BestnowelixirmysqlWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Bestnowelixirmysql.PubSub,
  live_view: [signing_salt: "QVkAZopR"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :bestnowelixirmysql, Bestnowelixirmysql.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian config
config :bestnowelixirmysql, BestnowelixirmysqlWeb.Auth.Guardian,
  issuer: "bestnowelixirmysql",
  secret_key: "xdV5TyibRS4PgSTe+fEu4XwatfEqZ3y1glywHsw9aivLCpehN9/5QCrXkpj+SISY"

config :at_ex,
  api_key: "f69a9ac7e25242e426da5b0f4401a33436aa9ec772a8d7b27050d98349f80fcd",
  # When changed to "false" one will use the live endpoint url
  sandbox: true,
  username: "stimapap",
  stk_product_name: "AtEx",
  b2c_product_name: "AtEx",
  b2b_product_name: "AtEx",
  bank_checkout_product_name: "AtEx",
  bank_transfer_product_name: "AtEx",
  card_checkout_product_name: "AtEx"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

import_config "appsignal.exs"
