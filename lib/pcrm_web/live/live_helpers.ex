defmodule PcrmWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.customer_index_path(@socket, :index)}>
        <.live_component
          module={PcrmWeb.CustomerLive.FormComponent}
          id={@customer.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.customer_index_path(@socket, :index)}
          customer: @customer
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="bg-black-40 cu-pointer fade-in fixed h-100 left-0 o-01 top-0 w-100 z-1" phx-remove={hide_modal()}>
      <div
        id="modal-content"
        class="bg-white br2 center cu-default fade-in-scale mt5 pa4 shadow-1 w-90"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <%= if @return_to do %>
          <%= live_patch to: @return_to,
            id: "close",
            class: "f3 fr hover-dark-gray link mid-gray",
            phx_click: hide_modal() do
          %>
          <i class="fa-solid fa-rectangle-xmark"></i>
          <% end %>
        <% else %>
          <a id="close" href="#" class="f3 fr hover-dark-gray link mid-gray" phx-click={hide_modal()}><i class="fa-solid fa-rectangle-xmark"></i></a>
        <% end %>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
