defmodule Pcrm.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pcrm.Customers` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        family_name: "some family_name",
        given_name: "some given_name",
        honorific_prefix: "some honorific_prefix",
        honorific_suffix: "some honorific_suffix"
      })
      |> Pcrm.Customers.create_customer()

    customer
  end
end
