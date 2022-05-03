defmodule BestnowelixirmysqlWeb.JackpotController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Jackpots
  alias Bestnowelixirmysql.Jackpots.Jackpot
  alias Bestnowelixirmysql.Helpers

  action_fallback BestnowelixirmysqlWeb.FallbackController

  alias Bestnowelixirmysql.Repo

  def index(conn, _params) do
#    jackpots = Jackpots.list_jackpots()
    jackpots = Jackpot.list_jackpots_descend()
    render(conn, "index.json", jackpots: jackpots)
  end

  def create(conn, %{"jackpot" => jackpot_params}) do
    IO.inspect jackpot_params["games"], label: "games"
    with {:ok, %Jackpot{} = jackpot} <- Jackpots.create_jackpot(jackpot_params) do

      Enum.each(Map.get(jackpot_params, "games"), fn g ->
        Ecto.build_assoc(jackpot, :jackpotgames, %{
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
#      |> put_status(:created)
      |> json jackpot |> Bestnowelixirmysql.Helpers.map_from_schema
#      |> put_resp_header("location", Routes.jackpot_path(conn, :show, jackpot))
#      |> render("show.json", jackpot: jackpot)
    end
  end

  def show_preload(conn, %{"id" => id}) do
    jackpot = Jackpots.get_jackpot!(id)
    render(conn, "show.json", jackpot: jackpot)
  end

  def show(conn, %{"id" => id}) do
#    jackpot = Jackpots.get_jackpot!(id)
#    render(conn, "show.json", jackpot: jackpot)
    jackpot = Jackpot.get_by_id_preload!(id)
    |> Enum.map(&Helpers.map_from_schema/1)

    conn
    |> json(jackpot)
  end

  def update(conn, %{"id" => id, "jackpot" => jackpot_params}) do
    jackpot = Jackpots.get_jackpot!(id)

    with {:ok, %Jackpot{} = jackpot} <- Jackpots.update_jackpot(jackpot, jackpot_params) do
      render(conn, "show.json", jackpot: jackpot)
    end
  end

  def delete(conn, %{"id" => id}) do
    jackpot = Jackpots.get_jackpot!(id)

    with {:ok, %Jackpot{}} <- Jackpots.delete_jackpot(jackpot) do
      send_resp(conn, :no_content, "")
    end
  end
end
