defmodule PcrmWeb.LiveLocale do
  import Phoenix.LiveView

  def on_mount(:default, _params, %{"locale" => locale} = _session, socket) do
    Gettext.put_locale(PcrmWeb.Gettext, locale)

    {:cont, socket}
  end
end
