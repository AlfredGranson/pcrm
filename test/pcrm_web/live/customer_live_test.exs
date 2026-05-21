defmodule PcrmWeb.CustomerLiveTest do
  use PcrmWeb.ConnCase

  import Phoenix.LiveViewTest
  import Pcrm.CustomersFixtures

  @create_attrs %{
    family_name: "some family_name",
    given_name: "some given_name",
    honorific_prefix: "some honorific_prefix",
    honorific_suffix: "some honorific_suffix"
  }
  @update_attrs %{
    family_name: "some updated family_name",
    given_name: "some updated given_name",
    honorific_prefix: "some updated honorific_prefix",
    honorific_suffix: "some updated honorific_suffix"
  }
  @invalid_attrs %{family_name: nil}

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end

  describe "Index" do
    setup [:create_customer]

    test "lists all customers", %{conn: conn, customer: customer} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      {:ok, _index_live, html} = live(conn, ~p"/customers")

      assert html =~ "Listing Customers"
      assert html =~ customer.family_name
    end

    test "saves new customer", %{conn: conn} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live |> element("a", "New Customer") |> render_click() =~ "New Customer"

      assert_patch(index_live, ~p"/customers/new")

      assert index_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#customer-form", customer: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/customers")

      assert html =~ "Customer created successfully"
      assert html =~ "some family_name"
    end

    test "updates customer in listing", %{conn: conn, customer: customer} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live
             |> element("#customer-#{customer.id} a", "Edit")
             |> render_click() =~ "Edit Customer"

      assert_patch(index_live, ~p"/customers/#{customer.id}/edit")

      assert index_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#customer-form", customer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/customers")

      assert html =~ "Customer updated successfully"
      assert html =~ "some updated family_name"
    end

    test "deletes customer in listing", %{conn: conn, customer: customer} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live |> element("#customer-#{customer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#customer-#{customer.id}")
    end
  end

  describe "Show" do
    setup [:create_customer]

    test "displays customer", %{conn: conn, customer: customer} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      {:ok, _show_live, html} = live(conn, ~p"/customers/#{customer.id}")

      assert html =~ "Show Customer"
      assert html =~ customer.family_name
    end

    test "updates customer within modal", %{conn: conn, customer: customer} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      {:ok, show_live, _html} = live(conn, ~p"/customers/#{customer.id}")

      assert show_live |> element("a", "Edit") |> render_click() =~ "Edit Customer"

      assert_patch(show_live, ~p"/customers/#{customer.id}/show/edit")

      assert show_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#customer-form", customer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, ~p"/customers/#{customer.id}")

      assert html =~ "Customer updated successfully"
      assert html =~ "some updated family_name"
    end
  end
end
