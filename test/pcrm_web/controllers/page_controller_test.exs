defmodule PcrmWeb.PageControllerTest do
  use PcrmWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to pcrm!"
  end
end
