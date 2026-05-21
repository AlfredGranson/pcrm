defmodule PcrmWeb.CustomerLive.Form do
  use PcrmWeb, :live_view

  alias Pcrm.Customers
  alias Pcrm.Customers.Customer

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      {@page_title}
    </.header>

    <.form for={@form} id="customer-form" phx-change="validate" phx-submit="save">
      <div class="grid grid-cols-1 gap-4 lg:grid-cols-2">
        <.input field={@form[:honorific_prefix]} label={dgettext("customers", "Honorific Prefix")} />
        <.input field={@form[:given_name]} label={dgettext("customers", "Given name")} />
        <.input field={@form[:family_name]} label={dgettext("customers", "Family name")} />
        <.input field={@form[:honorific_suffix]} label={dgettext("customers", "Honorific Suffix")} />
      </div>

      <footer class="flex items-center gap-3 mt-6">
        <.button type="submit" phx-disable-with={gettext("Saving...")}>
          <i class="fa-solid fa-floppy-disk" aria-hidden="true"></i>
          {gettext("Save")}
        </.button>
        <.button navigate={return_path(@return_to, @customer)} variant="secondary">
          {gettext("Cancel")}
        </.button>
      </footer>
    </.form>
    """
  end

  @impl true
  def mount(params, _session, socket) do
    {:ok,
     socket
     |> assign(:return_to, return_to(params["return_to"]))
     |> apply_action(socket.assigns.live_action, params)}
  end

  defp return_to("show"), do: "show"
  defp return_to(_), do: "index"

  defp apply_action(socket, :edit, %{"id" => id}) do
    customer = Customers.get_customer!(id)

    socket
    |> assign(:page_title, dgettext("customers", "Edit Customer"))
    |> assign(:customer, customer)
    |> assign(:form, to_form(Customers.change_customer(customer)))
  end

  defp apply_action(socket, :new, _params) do
    customer = %Customer{}

    socket
    |> assign(:page_title, dgettext("customers", "New Customer"))
    |> assign(:customer, customer)
    |> assign(:form, to_form(Customers.change_customer(customer)))
  end

  @impl true
  def handle_event("validate", %{"customer" => customer_params}, socket) do
    changeset = Customers.change_customer(socket.assigns.customer, customer_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"customer" => customer_params}, socket) do
    save_customer(socket, socket.assigns.live_action, customer_params)
  end

  defp save_customer(socket, :edit, customer_params) do
    case Customers.update_customer(socket.assigns.customer, customer_params) do
      {:ok, %{model: customer}} ->
        {:noreply,
         socket
         |> put_flash(:info, dgettext("customers", "Customer updated successfully"))
         |> push_navigate(to: return_path(socket.assigns.return_to, customer))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_customer(socket, :new, customer_params) do
    case Customers.create_customer(customer_params) do
      {:ok, %{model: customer}} ->
        {:noreply,
         socket
         |> put_flash(:info, dgettext("customers", "Customer created successfully"))
         |> push_navigate(to: return_path(socket.assigns.return_to, customer))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp return_path("index", _customer), do: ~p"/customers"
  defp return_path("show", customer), do: ~p"/customers/#{customer}"
end
