defmodule BestnowelixirmysqlWeb.SmsgameController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Smsgames
  alias Bestnowelixirmysql.Smsgames.Smsgame

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    smsgames = Smsgames.list_smsgames()
    render(conn, "index.json", smsgames: smsgames)
  end

  def create(conn, %{"smsgame" => smsgame_params}) do
    smsgame_params
    |> process_date

    with {:ok, %Smsgame{} = smsgame} <- Smsgames.create_smsgame(smsgame_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.smsgame_path(conn, :show, smsgame))
      |> render("show.json", smsgame: smsgame)
    end
  end

  def process_date(att) do
    Map.put(%{"amount" => att["amount"], "games" => att["games"], "commence" => att["commence"]}, "commence", att["commence"] <> " 00:00:00")
    |> IO.inspect
  end

  defp convert_to

  def show(conn, %{"id" => id}) do
    smsgame = Smsgames.get_smsgame!(id)
    render(conn, "show.json", smsgame: smsgame)
  end

  def update(conn, %{"id" => id, "smsgame" => smsgame_params}) do
    smsgame = Smsgames.get_smsgame!(id)

    with {:ok, %Smsgame{} = smsgame} <- Smsgames.update_smsgame(smsgame, smsgame_params) do
      render(conn, "show.json", smsgame: smsgame)
    end
  end

  def delete(conn, %{"id" => id}) do
    smsgame = Smsgames.get_smsgame!(id)

    with {:ok, %Smsgame{}} <- Smsgames.delete_smsgame(smsgame) do
      send_resp(conn, :no_content, "")
    end
  end
end
