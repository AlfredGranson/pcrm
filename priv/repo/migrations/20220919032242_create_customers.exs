defmodule Pcrm.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :given_name, :string
      add :family_name, :string

      timestamps()
    end
  end
end
