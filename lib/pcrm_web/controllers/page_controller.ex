defmodule PcrmWeb.PageController do
  use PcrmWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
