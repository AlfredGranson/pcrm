defmodule Pcrm.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :honorific_prefix, :string
      add :given_name, :string
      add :family_name, :string
      add :honorific_suffix, :string

      timestamps()
    end
  end
end
