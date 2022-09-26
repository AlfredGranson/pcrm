defmodule PcrmWeb.IndexLiveTest do
  use PcrmWeb.ConnCase

  test "GET /", %{conn: conn} do
    # Authenticated routes require a logged in user
    %{conn: conn} = register_and_log_in_user(%{conn: conn})

    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to pcrm!"
  end

  test "GET / in spanish (locale functionality)", %{conn: conn} do
    # Authenticated routes require a logged in user
    %{conn: conn} = register_and_log_in_user(%{conn: conn})

    conn = get(conn, "/?locale=es")
    assert html_response(conn, 200) =~ "¡Bienvenido a pcrm!"
  end
end
