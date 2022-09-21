defmodule PcrmWeb.Plugs.Locale do
  import Plug.Conn

  @locales Gettext.known_locales(PcrmWeb.Gettext)

  def init(default_locale), do: default_locale

  def call(%Plug.Conn{params: %{"locale" => locale}} = conn, _default_locale) do
    set_locale(conn, locale)
  end

  def call(conn, default_locale) do
    set_locale(conn, conn.cookies["locale"] || default_locale)
  end

  defp set_locale(conn, locale)
      when locale in @locales do

    Gettext.put_locale(PcrmWeb.Gettext, locale)

    conn
    |> put_resp_cookie("locale", locale, max_age: :timer.hours(24) * 365)
    |> assign(:locale, locale)
    |> put_session("locale", locale)
  end
end
