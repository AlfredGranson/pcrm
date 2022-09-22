defmodule Pcrm.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", "DROP EXTENSION IF EXISTS citext"

    create table(:customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      
      add :honorific_prefix, :citext
      add :given_name, :citext
      add :family_name, :citext, null: false
      add :honorific_suffix, :citext

      timestamps()
    end
  end
end
