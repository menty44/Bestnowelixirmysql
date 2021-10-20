defmodule BestnowelixirmysqlWeb.InfosController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Bet
  alias Bestnowelixirmysql.Bet.Infos

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    info = Bet.list_info()
    render(conn, "index.json", info: info)
  end

  def create(conn, %{"infos" => infos_params}) do
    with {:ok, %Infos{} = infos} <- Bet.create_infos(infos_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.infos_path(conn, :show, infos))
      |> render("show.json", infos: infos)
    end
  end

  def show(conn, %{"info_id" => info_id}) do
    infos = Bet.get_infos!(info_id)
    render(conn, "show.json", infos: infos)
  end

  def update(conn, %{"info_id" => info_id, "infos" => infos_params}) do
    infos = Bet.get_infos!(info_id)

    with {:ok, %Infos{} = infos} <- Bet.update_infos(infos, infos_params) do
      render(conn, "show.json", infos: infos)
    end
  end

  def delete(conn, %{"info_id" => info_id}) do
    infos = Bet.get_infos!(info_id)

    with {:ok, %Infos{}} <- Bet.delete_infos(infos) do
      send_resp(conn, :no_content, "")
    end
  end
end
