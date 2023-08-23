# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :github_info_api,
  ecto_repos: [GithubInfoApi.Repo]

config :github_info_api, GithubInfoApi.Repo, migration_primary_key: [type: :binary_id]

config :github_info_api, GithubInfoApi.Infos.Get, github_adapter: GithubInfoApi.GithubApi.Client

config :github_info_api, GithubInfoApiWeb.Auth.Guardian,
  issuer: "github_info_api",
  secret_key: "aEXDbjlo4RX148n4K6Ch0VGc2Ce6LjethZA2/qQ+qTnwhWMUNKWQ5+cYGPOnPfZv",
  ttl: {1, :minute}

config :github_info_api, GithubInfoApiWeb.Auth.Pipeline,
  module: GithubInfoApiWeb.Auth.Guardian,
  error_handler: GithubInfoApiWeb.Auth.ErrorHandler

# Configures the endpoint
config :github_info_api, GithubInfoApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [json: GithubInfoApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: GithubInfoApi.PubSub,
  live_view: [signing_salt: "zwiXfmIU"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :github_info_api, GithubInfoApi.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
