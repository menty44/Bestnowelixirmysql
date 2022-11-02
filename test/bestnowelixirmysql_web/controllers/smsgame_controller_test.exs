defmodule BestnowelixirmysqlWeb.SmsgameControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.SmsgamesFixtures

  alias Bestnowelixirmysql.Smsgames.Smsgame

  @create_attrs %{
    amount: "some amount",
    games: "some games"
  }
  @update_attrs %{
    amount: "some updated amount",
    games: "some updated games"
  }
  @invalid_attrs %{amount: nil, games: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all smsgames", %{conn: conn} do
      conn = get(conn, Routes.smsgame_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create smsgame" do
    test "renders smsgame when data is valid", %{conn: conn} do
      conn = post(conn, Routes.smsgame_path(conn, :create), smsgame: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.smsgame_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "some amount",
               "games" => "some games"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.smsgame_path(conn, :create), smsgame: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update smsgame" do
    setup [:create_smsgame]

    test "renders smsgame when data is valid", %{conn: conn, smsgame: %Smsgame{id: id} = smsgame} do
      conn = put(conn, Routes.smsgame_path(conn, :update, smsgame), smsgame: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.smsgame_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "some updated amount",
               "games" => "some updated games"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, smsgame: smsgame} do
      conn = put(conn, Routes.smsgame_path(conn, :update, smsgame), smsgame: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete smsgame" do
    setup [:create_smsgame]

    test "deletes chosen smsgame", %{conn: conn, smsgame: smsgame} do
      conn = delete(conn, Routes.smsgame_path(conn, :delete, smsgame))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.smsgame_path(conn, :show, smsgame))
      end
    end
  end

  defp create_smsgame(_) do
    smsgame = smsgame_fixture()
    %{smsgame: smsgame}
  end
end
