defmodule Pcrm.Repo do
  use Ecto.Repo,
    otp_app: :pcrm,
    adapter: Ecto.Adapters.Postgres
end
