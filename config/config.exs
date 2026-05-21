import Config

config :pcrm,
  ecto_repos: [Pcrm.Repo]

config :pcrm, PcrmWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [formats: [html: PcrmWeb.ErrorHTML, json: PcrmWeb.ErrorJSON], layout: false],
  pubsub_server: Pcrm.PubSub,
  live_view: [signing_salt: "Ahosa0SD"]

config :pcrm, Pcrm.Mailer, adapter: Swoosh.Adapters.Local

config :swoosh, :api_client, false

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :esbuild,
  version: "0.28.0",
  default: [
    args:
      ~w(js/app.js css/fa.css --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/* --loader:.ttf=file --loader:.woff2=file --loader:.woff=file --loader:.eot=file --loader:.svg=file),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.4.17",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

import_config "#{config_env()}.exs"

config :pcrm, PcrmWeb.Gettext,
  default_locale: "en",
  locales: ~w(en es)

config :paper_trail,
  repo: Pcrm.Repo,
  item_type: :binary_id,
  originator_type: :binary_id,
  originator_relationship_options: [references: :binary_id],
  originator: [name: :user, model: Pcrm.Users.User]
