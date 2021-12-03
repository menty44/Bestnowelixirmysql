defmodule BestnowelixirmysqlWeb.GameControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.GamesFixtures

  alias Bestnowelixirmysql.Games.Game

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
    test "lists all games", %{conn: conn} do
      conn = get(conn, Routes.game_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create game" do
    test "renders game when data is valid", %{conn: conn} do
      conn = post(conn, Routes.game_path(conn, :create), game: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.game_path(conn, :show, id))

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
      conn = post(conn, Routes.game_path(conn, :create), game: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update game" do
    setup [:create_game]

    test "renders game when data is valid", %{conn: conn, game: %Game{id: id} = game} do
      conn = put(conn, Routes.game_path(conn, :update, game), game: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.game_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "league" => "some updated league",
               "match" => "some updated match",
               "results" => "some updated results",
               "time" => "some updated time",
               "tip" => "some updated tip"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, game: game} do
      conn = put(conn, Routes.game_path(conn, :update, game), game: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete game" do
    setup [:create_game]

    test "deletes chosen game", %{conn: conn, game: game} do
      conn = delete(conn, Routes.game_path(conn, :delete, game))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.game_path(conn, :show, game))
      end
    end
  end

  defp create_game(_) do
    game = game_fixture()
    %{game: game}
  end
end
