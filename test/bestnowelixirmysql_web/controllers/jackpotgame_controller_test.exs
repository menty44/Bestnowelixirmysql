defmodule BestnowelixirmysqlWeb.JackpotgameControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.JackgamesFixtures

  alias Bestnowelixirmysql.Jackgames.Jackpotgame

  @create_attrs %{
    league: "some league",
    match: "some match",
    results: "some results",
    time: "some time",
    tip: "some tip"
  }
  @update_attrs %{
    league: "some updated league",
    match: "some updated match",
    results: "some updated results",
    time: "some updated time",
    tip: "some updated tip"
  }
  @invalid_attrs %{league: nil, match: nil, results: nil, time: nil, tip: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all jackpotgames", %{conn: conn} do
      conn = get(conn, Routes.jackpotgame_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create jackpotgame" do
    test "renders jackpotgame when data is valid", %{conn: conn} do
      conn = post(conn, Routes.jackpotgame_path(conn, :create), jackpotgame: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.jackpotgame_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "league" => "some league",
               "match" => "some match",
               "results" => "some results",
               "time" => "some time",
               "tip" => "some tip"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.jackpotgame_path(conn, :create), jackpotgame: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update jackpotgame" do
    setup [:create_jackpotgame]

    test "renders jackpotgame when data is valid", %{
      conn: conn,
      jackpotgame: %Jackpotgame{id: id} = jackpotgame
    } do
      conn =
        put(conn, Routes.jackpotgame_path(conn, :update, jackpotgame), jackpotgame: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.jackpotgame_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "league" => "some updated league",
               "match" => "some updated match",
               "results" => "some updated results",
               "time" => "some updated time",
               "tip" => "some updated tip"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, jackpotgame: jackpotgame} do
      conn =
        put(conn, Routes.jackpotgame_path(conn, :update, jackpotgame), jackpotgame: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete jackpotgame" do
    setup [:create_jackpotgame]

    test "deletes chosen jackpotgame", %{conn: conn, jackpotgame: jackpotgame} do
      conn = delete(conn, Routes.jackpotgame_path(conn, :delete, jackpotgame))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.jackpotgame_path(conn, :show, jackpotgame))
      end
    end
  end

  defp create_jackpotgame(_) do
    jackpotgame = jackpotgame_fixture()
    %{jackpotgame: jackpotgame}
  end
end
