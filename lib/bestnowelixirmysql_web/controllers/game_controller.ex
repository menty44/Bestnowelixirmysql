defmodule BestnowelixirmysqlWeb.GameController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Games
  alias Bestnowelixirmysql.Games.Game

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    games = Games.list_games()
    render(conn, "index.json", games: games)
  end

  def archive(conn, _params) do
    {:ok, games} = Bestnowelixirmysql.Games.games_archive_by_date!()
    render(conn, "index.json", games: games)
  end

  def active(conn, _params) do
    {:ok, games} = Bestnowelixirmysql.Games.games_active_by_date!()
    render(conn, "index.json", games: games)
  end

  def create(conn, %{"game" => game_params}) do
    with {:ok, %Game{} = game} <- Games.create_game(game_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.game_path(conn, :show, game))
      |> render("show.json", game: game)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    render(conn, "show.json", game: game)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Games.get_game!(id)

    with {:ok, %Game{} = game} <- Games.update_game(game, game_params) do
      render(conn, "show.json", game: game)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Games.get_game!(id)

    with {:ok, %Game{}} <- Games.delete_game(game) do
      send_resp(conn, :no_content, "")
    end
  end

  def filter_by_date_query(conn, %{"date" => date}) do
    IO.inspect(date["from"])
    IO.inspect(date["to"])
    games = Games.filter_by_date_query(date["from"], date["to"])
    render(conn, "index.json", games: games)
    # json(conn, %{users: "kaka"})
    # conn
    # |> json(%{"date" => date})
  end
end
