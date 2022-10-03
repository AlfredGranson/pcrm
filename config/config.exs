# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :pcrm,
  ecto_repos: [Pcrm.Repo]

# Configures the endpoint
config :pcrm, PcrmWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PcrmWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pcrm.PubSub,
  live_view: [signing_salt: "Ahosa0SD"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :pcrm, Pcrm.Mailer, adapter: Swoosh.Adapters.Local

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

# Configure supported locales
config :pcrm, PcrmWeb.Gettext,
  default_locale: "en",
  locales: ~w(en es)

# Configure Paper Trail
config :paper_trail,
  repo: Pcrm.Repo,
  item_type: :binary_id,
  originator_type: :binary_id,
  originator_relationship_options: [references: :binary_id],
  originator: [name: :user, model: Pcrm.Users.User]
