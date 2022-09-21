defmodule Pcrm.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :family_name, :string
    field :given_name, :string
    field :honorific_prefix, :string
    field :honorific_suffix, :string

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:honorific_prefix, :given_name, :family_name, :honorific_suffix])
    |> validate_required([:honorific_prefix, :given_name, :family_name, :honorific_suffix])
  end
end
