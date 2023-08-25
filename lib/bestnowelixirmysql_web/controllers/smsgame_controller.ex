defmodule BestnowelixirmysqlWeb.SmsgameController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Smsgames
  alias Bestnowelixirmysql.Smsgames.Smsgame

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    smsgames = Smsgames.list_smsgames()
    render(conn, "index.json", smsgames: smsgames)
  end

  def tillcreate(conn, %{"smsgame" => smsgame_till_params}) do
    params =
      smsgame_till_params
      |> process_date
    smsgame_till_params |> IO.inspect
    with {:ok, %Bestnowelixirmysql.Tillgames.Tillgame{} = smssaved} <- Bestnowelixirmysql.Tillgames.create_tillgame(params) do
      smssaved |> IO.inspect
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.smsgame_path(conn, :show, smssaved))
      |> render("show.json", smsgame: smssaved)
#      conn
#      |> put_status(:ok)
#      |> json(%{
#        data:  smssaved |> Bestnowelixirmysql.Helpers.map_from_schema()
#      })
    end
  end

  def gettillgames(conn, _) do
    till = Bestnowelixirmysql.Tillgames.list_tillgames()

      conn
      |> put_status(:ok)
      |> json(%{
        data:  Enum.map(till, fn x -> x |> Bestnowelixirmysql.Helpers.map_from_schema() end)
      })

  end

  def create(conn, %{"smsgame" => smsgame_params}) do
    params =
      smsgame_params
      |> process_date

    with {:ok, %Smsgame{} = smsgame} <- Smsgames.create_smsgame(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.smsgame_path(conn, :show, smsgame))
      |> render("show.json", smsgame: smsgame)
    end
  end

  def process_date(att) do
    Map.put(
      %{"amount" => att["amount"], "games" => att["games"], "commence" => att["commence"]},
      "commence",
      att["commence"] <> " 00:00:00"
    )
    |> convert_to_naive_date()
  end

  defp convert_to_naive_date(att) do
    Map.put(
      %{"amount" => att["amount"], "games" => att["games"], "commence" => att["commence"]},
      "commence",
      NaiveDateTime.from_iso8601!(att["commence"])
    )
    |> IO.inspect()
  end

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

  def deletetillgames(conn, %{"id" => id}) do
    smsgame = Bestnowelixirmysql.Tillgames.get_tillgame!(id)

    with {:ok, %Bestnowelixirmysql.Tillgames.Tillgame{}} <- Bestnowelixirmysql.Tillgames.delete_tillgame(smsgame) do
      send_resp(conn, :no_content, "")
    end
  end
end
