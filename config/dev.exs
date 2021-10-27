import Config

# Configure your database
config :bestnowelixirmysql, Bestnowelixirmysql.Repo,
  username: "root",
  password: "XZB9O6G8fred.",
  database: "bestnowtech",
  hostname: "127.0.0.1",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :bestnowelixirmysql, BestnowelixirmysqlWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "Ly6wWyW6Nut4Wf+bpo/BuAA5+RS+nYk/w290O4N0j8fRdj3dnAK4pDEqIce7k807",
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :bestnowelixirmysql, BestnowelixirmysqlWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/bestnowelixirmysql_web/(live|views)/.*(ex)$",
      ~r"lib/bestnowelixirmysql_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

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

config :corsica, Corsica,
       log: [rejected: :warn, invalid: :debug, accepted: :debug],
       origins: ["http://localhost:4200"]
