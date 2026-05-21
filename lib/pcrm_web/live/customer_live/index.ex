defmodule PcrmWeb.CustomerLive.Index do
  use PcrmWeb, :live_view

  alias Pcrm.Customers

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      {dgettext("customers", "Listing Customers")}
      <:actions>
        <.button navigate={~p"/customers/new"}>
          <.icon name="fa-solid fa-plus" /> {dgettext("customers", "New Customer")}
        </.button>
      </:actions>
    </.header>

    <.table
      id="customers"
      rows={@streams.customers}
      row_click={fn {_id, customer} -> JS.navigate(~p"/customers/#{customer}") end}
    >
      <:col :let={{_id, customer}} label={dgettext("customers", "Honorific Prefix")}>{customer.honorific_prefix}</:col>
      <:col :let={{_id, customer}} label={dgettext("customers", "Given name")}>{customer.given_name}</:col>
      <:col :let={{_id, customer}} label={dgettext("customers", "Family name")}>{customer.family_name}</:col>
      <:col :let={{_id, customer}} label={dgettext("customers", "Honorific Suffix")}>{customer.honorific_suffix}</:col>
      <:action :let={{_id, customer}}>
        <.link navigate={~p"/customers/#{customer}"} class="text-blue-600 hover:text-blue-500">
          {gettext("Show")}
        </.link>
        <.link navigate={~p"/customers/#{customer}/edit"} class="text-blue-600 hover:text-blue-500">
          {gettext("Edit")}
        </.link>
      </:action>
      <:action :let={{id, customer}}>
        <.link
          phx-click={JS.push("delete", value: %{id: customer.id}) |> hide("##{id}")}
          data-confirm={gettext("Are you sure?")}
          class="text-red-600 hover:text-red-500 cursor-pointer"
        >
          {gettext("Delete")}
        </.link>
      </:action>
    </.table>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, dgettext("customers", "Listing Customers"))
     |> stream(:customers, Customers.list_customers())}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    customer = Customers.get_customer!(id)
    {:ok, _} = Customers.delete_customer(customer)
    {:noreply, stream_delete(socket, :customers, customer)}
  end
end
