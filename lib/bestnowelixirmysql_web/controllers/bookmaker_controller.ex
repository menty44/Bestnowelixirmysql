defmodule BestnowelixirmysqlWeb.BookmakerController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Bookmakers
  alias Bestnowelixirmysql.Bookmakers.Bookmaker

  alias Bestnowelixirmysql.Games
  alias Bestnowelixirmysql.Games.Game

  alias Bestnowelixirmysql.Repo


  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    bookmakers = Bookmakers.list_bookmakers()
    IO.inspect(bookmakers)
#    render(conn, "index.json", bookmakers: bookmakers)
  end

  def create(conn, %{"bookmaker" => bookmaker_params}) do
    Enum.each(Map.get(bookmaker_params, "games"), fn g ->
      save_book_marker = %Bookmaker{}
                         |> Bookmaker.changeset(bookmaker_params)
                         |> Repo.insert!()
      Ecto.build_assoc(save_book_marker, :games, %{
        league: Map.get(g, "league"),
        match: Map.get(g, "match"),
        results: Map.get(g, "results"),
        time: Map.get(g, "time"),
        tip: Map.get(g, "tip")
      })
      |> Repo.insert!
      |> IO.inspect
    end)

    conn
    |> put_status(:created)
    |> json(%{
      "code" => 0,
      "message" => "created"
    })
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
