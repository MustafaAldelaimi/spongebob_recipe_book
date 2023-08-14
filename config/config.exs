# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :spongebob_recipe_book,
  ecto_repos: [SpongebobRecipeBook.Repo]

# Configures the endpoint
config :spongebob_recipe_book, SpongebobRecipeBookWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: SpongebobRecipeBookWeb.ErrorHTML, json: SpongebobRecipeBookWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: SpongebobRecipeBook.PubSub,
  live_view: [signing_salt: "8K+TuU3G"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :spongebob_recipe_book, SpongebobRecipeBook.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :spongebob_recipe_book, SpongebobRecipeBookWeb.Auth.Guardian,
    issuer: "spongebob_recipe_book",
    secret_key: "zgjRXEzpfTEKg/vi0xSt5dSDNvoC5eNOUeYfAmwRlxPQrDxKCHzhLngcARNaUaE1"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :guardian, Guardian.DB,
  repo: SpongebobRecipeBook.Repo,
  schema_name: "guardian_tokens",
  sweep_interval: 60

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"