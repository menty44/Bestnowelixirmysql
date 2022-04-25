defmodule BestnowelixirmysqlWeb.JackpotController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Jackpots
  alias Bestnowelixirmysql.Jackpots.Jackpot

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    jackpots = Jackpots.list_jackpots()
    render(conn, "index.json", jackpots: jackpots)
  end

  def create(conn, %{"jackpot" => jackpot_params}) do
    with {:ok, %Jackpot{} = jackpot} <- Jackpots.create_jackpot(jackpot_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.jackpot_path(conn, :show, jackpot))
      |> render("show.json", jackpot: jackpot)
    end
  end

  def show(conn, %{"id" => id}) do
    jackpot = Jackpots.get_jackpot!(id)
    render(conn, "show.json", jackpot: jackpot)
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
