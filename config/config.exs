# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :frida,
  ecto_repos: [Frida.Repo]

# Configures the endpoint
config :frida, FridaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tVcs8OCusN4UFSLelfaudq2wTJbKk/cT/a8erwebNnCxSRvzx7R4voT8PmFCqPLN",
  render_errors: [view: FridaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Frida.PubSub,
  live_view: [signing_salt: "JXtmbeW+"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :frida, :pow,
  user: Frida.Users.User,
  repo: Frida.Repo,
  web_module: FridaWeb,
  extensions: [PowResetPassword, PowEmailConfirmation],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks,
  mailer_backend: FridaWeb.Pow.Mailer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
