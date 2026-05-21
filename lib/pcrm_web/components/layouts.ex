defmodule PcrmWeb.Layouts do
  use PcrmWeb, :html

  embed_templates "layouts/*"

  def user_menu(assigns) do
    ~H"""
    <ul class="flex gap-4 list-none m-0 p-0">
      <%= if @current_user do %>
        <li class="flex items-center gap-1 text-sm text-gray-700">
          <i class="fa-solid fa-circle-user" aria-hidden="true"></i>
          {@current_user.email}
        </li>
        <li>
          <.link href={~p"/users/settings"} class="text-sm text-gray-700 hover:text-gray-900">
            {gettext("Settings")}
          </.link>
        </li>
        <li>
          <.link
            href={~p"/users/log_out"}
            method="delete"
            class="text-sm text-gray-700 hover:text-gray-900"
          >
            {gettext("Log out")}
          </.link>
        </li>
      <% else %>
        <li>
          <.link href={~p"/users/register"} class="text-sm text-gray-700 hover:text-gray-900">
            {gettext("Register")}
          </.link>
        </li>
        <li>
          <.link href={~p"/users/log_in"} class="text-sm text-gray-700 hover:text-gray-900">
            {gettext("Log in")}
          </.link>
        </li>
      <% end %>
    </ul>
    """
  end
end
