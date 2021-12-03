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
    render(conn, "index.json", bookmakers: bookmakers)
  end

  def create(conn, %{"bookmaker" => bookmaker_params}) do
#    IO.inspect(Map.get(bookmaker_params, "games"))
    IO.inspect(Map.get(bookmaker_params, "loadingdate"))
    IO.inspect(Map.get(bookmaker_params, "keyword"))
    IO.inspect(Map.get(bookmaker_params, "owner"))
    IO.inspect(Map.get(bookmaker_params, "shortcode"))

    Enum.each(Map.get(bookmaker_params, "games"), fn g ->
      IO.inspect(g)


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

#    |> put_resp_header("location", Routes.bookmaker_path(conn, :show, save_book_marker))
#    |> render("show.json", bookmaker: save_book_marker)

#    with {:ok, %Bookmaker{} = bookmaker} <- Bookmakers.create_bookmaker(bookmaker_params) do
#      IO.inspect(bookmaker)
#      IO.inspect(Map.get(bookmaker, :id))
#      g = %Bestnowelixirmysql.Games.Game{
#             "time": "7.30",
#             "league": "La liga",
#             "match": "Westbrom X Juventus",
#             "tip": "1",
#             "results": "1"
#           }
#           IO.inspect Map.merge(g, %{bookmaker: bookmaker}) |> Repo.insert()
#
##      Repo.preload(bookmaker, [:games])
##      Repo.insert(Map.merge(g, %{bookmakers_id: Map.get(bookmaker, :id) }))
##          gg = %Bestnowelixirmysql.Games.Game{}
##          student = %Student{name:"John Doe", course_id: 1}
##      bookmaker |> Repo.preload [:games] |> IO.inspect
##      IO.inspect Repo.preload(Bestnowelixirmysql.Bookmakers.Bookmaker, :games)
##      Games.create_game(Map.merge(g,%{bookmaker_id: Map.get(bookmaker, :id)}))
#      bookmaker
##      |> Ecto.build_assoc( :games, %{
##                                     "time": "7.30",
##                                     "league": "La liga",
##                                     "match": "Westbrom X Juventus",
##                                     "tip": "1",
##                                     "results": "1"
##                                   })
#      conn
#      |> put_status(:created)
#      |> put_resp_header("location", Routes.bookmaker_path(conn, :show, bookmaker))
#      |> render("show.json", bookmaker: bookmaker)
##      IO.inspect(bookmaker)
##      gx = Ecto.build_assoc(bookmaker, :games, %{
##        "time": "7.30",
##        "league": "La liga",
##        "match": "Westbrom X Juventus",
##        "tip": "1",
##        "results": "1"
##      })
##              game = Ecto.build_assoc(bookmaker, :games, gx)
##              g =  Repo.insert!(game)
##      Enum.each(Map.get(bookmaker_params, "games"), fn x ->
##      IO.inspect(x)
##        game = Ecto.build_assoc(bookmaker, :games, x)
##        g =  Repo.insert!(game)
###        IO.puts x
##        IO.puts g
##      end)
#    end

#    with {:ok, %Bookmaker{} = bookmaker} <- Bookmakers.create_bookmaker(bookmaker_params) do
#      conn
#      |> put_status(:created)
#      |> put_resp_header("location", Routes.bookmaker_path(conn, :show, bookmaker))
#      |> render("show.json", bookmaker: bookmaker)
#    end
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
