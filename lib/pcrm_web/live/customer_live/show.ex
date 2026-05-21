defmodule PcrmWeb.CustomerLive.Show do
  use PcrmWeb, :live_view

  alias Pcrm.Customers

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      {dgettext("customers", "Show Customer")}
      <:actions>
        <.button navigate={~p"/customers"} variant="secondary">
          <.icon name="fa-solid fa-arrow-left" /> {gettext("Back")}
        </.button>
        <.button navigate={~p"/customers/#{@customer}/edit?return_to=show"}>
          <.icon name="fa-solid fa-pencil" /> {gettext("Edit")}
        </.button>
      </:actions>
    </.header>

    <.list>
      <:item title={dgettext("customers", "Honorific Prefix")}>{@customer.honorific_prefix}</:item>
      <:item title={dgettext("customers", "Given name")}>{@customer.given_name}</:item>
      <:item title={dgettext("customers", "Family name")}>{@customer.family_name}</:item>
      <:item title={dgettext("customers", "Honorific Suffix")}>{@customer.honorific_suffix}</:item>
    </.list>
    """
  end

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, dgettext("customers", "Show Customer"))
     |> assign(:customer, Customers.get_customer!(id))}
  end
end
