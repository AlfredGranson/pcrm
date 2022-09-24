defmodule PcrmWeb.CustomerLiveTest do
  use PcrmWeb.ConnCase

  import Phoenix.LiveViewTest
  import Pcrm.CustomersFixtures

  @create_attrs %{family_name: "some family_name", given_name: "some given_name", honorific_prefix: "some honorific_prefix", honorific_suffix: "some honorific_suffix"}
  @update_attrs %{family_name: "some updated family_name", given_name: "some updated given_name", honorific_prefix: "some updated honorific_prefix", honorific_suffix: "some updated honorific_suffix"}
  @invalid_attrs %{family_name: nil, given_name: nil, honorific_prefix: nil, honorific_suffix: nil}

  defp create_customer(_) do
    customer = customer_fixture()
    %{customer: customer}
  end

  describe "Index" do
    setup [:create_customer]

    test "lists all customers", %{conn: conn, customer: customer} do
      # Authenticated routes require a logged in user
      %{conn: conn} = register_and_log_in_user(%{conn: conn})

      {:ok, _index_live, html} = live(conn, Routes.customer_index_path(conn, :index))

      assert html =~ "Listing Customers"
      assert html =~ customer.family_name
    end

    test "saves new customer", %{conn: conn} do
      # Authenticated routes require a logged in user
      %{conn: conn} = register_and_log_in_user(%{conn: conn})

      {:ok, index_live, _html} = live(conn, Routes.customer_index_path(conn, :index))

      assert index_live |> element("a", "New Customer") |> render_click() =~
               "New Customer"

      assert_patch(index_live, Routes.customer_index_path(conn, :new))

      assert index_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#customer-form", customer: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.customer_index_path(conn, :index))

      assert html =~ "Customer created successfully"
      assert html =~ "some family_name"
    end

    test "updates customer in listing", %{conn: conn, customer: customer} do
      # Authenticated routes require a logged in user
      %{conn: conn} = register_and_log_in_user(%{conn: conn})

      {:ok, index_live, _html} = live(conn, Routes.customer_index_path(conn, :index))

      assert index_live |> element("#customer-#{customer.id} a", "Edit") |> render_click() =~
               "Edit Customer"

      assert_patch(index_live, Routes.customer_index_path(conn, :edit, customer))

      assert index_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#customer-form", customer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.customer_index_path(conn, :index))

      assert html =~ "Customer updated successfully"
      assert html =~ "some updated family_name"
    end

    test "deletes customer in listing", %{conn: conn, customer: customer} do
      # Authenticated routes require a logged in user
      %{conn: conn} = register_and_log_in_user(%{conn: conn})

      {:ok, index_live, _html} = live(conn, Routes.customer_index_path(conn, :index))

      assert index_live |> element("#customer-#{customer.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#customer-#{customer.id}")
    end
  end

  describe "Show" do
    setup [:create_customer]

    test "displays customer", %{conn: conn, customer: customer} do
      # Authenticated routes require a logged in user
      %{conn: conn} = register_and_log_in_user(%{conn: conn})

      {:ok, _show_live, html} = live(conn, Routes.customer_show_path(conn, :show, customer))

      assert html =~ "Show Customer"
      assert html =~ customer.family_name
    end

    test "updates customer within modal", %{conn: conn, customer: customer} do
      # Authenticated routes require a logged in user
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      
      {:ok, show_live, _html} = live(conn, Routes.customer_show_path(conn, :show, customer))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Customer"

      assert_patch(show_live, Routes.customer_show_path(conn, :edit, customer))

      assert show_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#customer-form", customer: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.customer_show_path(conn, :show, customer))

      assert html =~ "Customer updated successfully"
      assert html =~ "some updated family_name"
    end
  end
end
