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

      assert {:ok, form_live, _} =
               index_live
               |> element("a", "New Customer")
               |> render_click()
               |> follow_redirect(conn, ~p"/customers/new")

      assert render(form_live) =~ "New Customer"

      assert form_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#customer-form", customer: @create_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/customers")

      html = render(index_live)
      assert html =~ "Customer created successfully"
      assert html =~ "some family_name"
    end

    test "updates customer in listing", %{conn: conn, customer: customer} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert {:ok, form_live, _html} =
               index_live
               |> element("#customers-#{customer.id} a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/customers/#{customer.id}/edit")

      assert render(form_live) =~ "Edit Customer"

      assert form_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, index_live, _html} =
               form_live
               |> form("#customer-form", customer: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/customers")

      html = render(index_live)
      assert html =~ "Customer updated successfully"
      assert html =~ "some updated family_name"
    end

    test "deletes customer in listing", %{conn: conn, customer: customer} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      {:ok, index_live, _html} = live(conn, ~p"/customers")

      assert index_live
             |> element("#customers-#{customer.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#customers-#{customer.id}")
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

    test "updates customer and returns to show", %{conn: conn, customer: customer} do
      %{conn: conn} = register_and_log_in_user(%{conn: conn})
      {:ok, show_live, _html} = live(conn, ~p"/customers/#{customer.id}")

      assert {:ok, form_live, _} =
               show_live
               |> element("a", "Edit")
               |> render_click()
               |> follow_redirect(conn, ~p"/customers/#{customer.id}/edit?return_to=show")

      assert render(form_live) =~ "Edit Customer"

      assert form_live
             |> form("#customer-form", customer: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert {:ok, show_live, _html} =
               form_live
               |> form("#customer-form", customer: @update_attrs)
               |> render_submit()
               |> follow_redirect(conn, ~p"/customers/#{customer.id}")

      html = render(show_live)
      assert html =~ "Customer updated successfully"
      assert html =~ "some updated family_name"
    end
  end
end
