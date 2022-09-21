defmodule Pcrm.CustomersTest do
  use Pcrm.DataCase

  alias Pcrm.Customers

  describe "customers" do
    alias Pcrm.Customers.Customer

    import Pcrm.CustomersFixtures

    @invalid_attrs %{family_name: nil, given_name: nil, honorific_prefix: nil, honorific_srefix: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Customers.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Customers.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{family_name: "some family_name", given_name: "some given_name", honorific_prefix: "some honorific_prefix", honorific_srefix: "some honorific_srefix"}

      assert {:ok, %Customer{} = customer} = Customers.create_customer(valid_attrs)
      assert customer.family_name == "some family_name"
      assert customer.given_name == "some given_name"
      assert customer.honorific_prefix == "some honorific_prefix"
      assert customer.honorific_srefix == "some honorific_srefix"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{family_name: "some updated family_name", given_name: "some updated given_name", honorific_prefix: "some updated honorific_prefix", honorific_srefix: "some updated honorific_srefix"}

      assert {:ok, %Customer{} = customer} = Customers.update_customer(customer, update_attrs)
      assert customer.family_name == "some updated family_name"
      assert customer.given_name == "some updated given_name"
      assert customer.honorific_prefix == "some updated honorific_prefix"
      assert customer.honorific_srefix == "some updated honorific_srefix"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_customer(customer, @invalid_attrs)
      assert customer == Customers.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Customers.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Customers.change_customer(customer)
    end
  end
end
