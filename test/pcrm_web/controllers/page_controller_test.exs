defmodule PcrmWeb.PageControllerTest do
  use PcrmWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to pcrm!"
  end

  test "GET / in spanish (locale functionality)", %{conn: conn} do
    conn = get(conn, "/?locale=es")
    assert html_response(conn, 200) =~ "¡Bienvenido a pcrm!"
  end
end
