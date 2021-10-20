defmodule BestnowelixirmysqlWeb.PageController do
  use BestnowelixirmysqlWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
