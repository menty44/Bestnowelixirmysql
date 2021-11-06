defmodule BestnowelixirmysqlWeb.BookmakerController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Bookmakers
  alias Bestnowelixirmysql.Bookmakers.Bookmaker

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    bookmakers = Bookmakers.list_bookmakers()
    render(conn, "index.json", bookmakers: bookmakers)
  end

  def create(conn, %{"bookmaker" => bookmaker_params}) do
    with {:ok, %Bookmaker{} = bookmaker} <- Bookmakers.create_bookmaker(bookmaker_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.bookmaker_path(conn, :show, bookmaker))
      |> render("show.json", bookmaker: bookmaker)
    end
  end

  def show(conn, %{"id" => id}) do
    bookmaker = Bookmakers.get_bookmaker!(id)
    render(conn, "show.json", bookmaker: bookmaker)
  end

  def update(conn, %{"id" => id, "bookmaker" => bookmaker_params}) do
    bookmaker = Bookmakers.get_bookmaker!(id)

    with {:ok, %Bookmaker{} = bookmaker} <-
           Bookmakers.update_bookmaker(bookmaker, bookmaker_params) do
      render(conn, "show.json", bookmaker: bookmaker)
    end
  end

  def delete(conn, %{"id" => id}) do
    bookmaker = Bookmakers.get_bookmaker!(id)

    with {:ok, %Bookmaker{}} <- Bookmakers.delete_bookmaker(bookmaker) do
      send_resp(conn, :no_content, "")
    end
  end
end
