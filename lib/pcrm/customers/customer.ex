defmodule Pcrm.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :family_name, :string
    field :given_name, :string

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:given_name, :family_name])
    |> validate_required([:given_name, :family_name])
  end
end
