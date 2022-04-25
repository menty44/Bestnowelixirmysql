defmodule BestnowelixirmysqlWeb.JackpotgameController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Jackgames
  alias Bestnowelixirmysql.Jackgames.Jackpotgame

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    jackpotgames = Jackgames.list_jackpotgames()
    render(conn, "index.json", jackpotgames: jackpotgames)
  end

  def create(conn, %{"jackpotgame" => jackpotgame_params}) do
    with {:ok, %Jackpotgame{} = jackpotgame} <- Jackgames.create_jackpotgame(jackpotgame_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.jackpotgame_path(conn, :show, jackpotgame))
      |> render("show.json", jackpotgame: jackpotgame)
    end
  end

  def show(conn, %{"id" => id}) do
    jackpotgame = Jackgames.get_jackpotgame!(id)
    render(conn, "show.json", jackpotgame: jackpotgame)
  end

  def update(conn, %{"id" => id, "jackpotgame" => jackpotgame_params}) do
    jackpotgame = Jackgames.get_jackpotgame!(id)

    with {:ok, %Jackpotgame{} = jackpotgame} <- Jackgames.update_jackpotgame(jackpotgame, jackpotgame_params) do
      render(conn, "show.json", jackpotgame: jackpotgame)
    end
  end

  def delete(conn, %{"id" => id}) do
    jackpotgame = Jackgames.get_jackpotgame!(id)

    with {:ok, %Jackpotgame{}} <- Jackgames.delete_jackpotgame(jackpotgame) do
      send_resp(conn, :no_content, "")
    end
  end
end
