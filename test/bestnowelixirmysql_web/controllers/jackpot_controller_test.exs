defmodule BestnowelixirmysqlWeb.JackpotControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.JackpotsFixtures

  alias Bestnowelixirmysql.Jackpots.Jackpot

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all jackpots", %{conn: conn} do
      conn = get(conn, Routes.jackpot_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create jackpot" do
    test "renders jackpot when data is valid", %{conn: conn} do
      conn = post(conn, Routes.jackpot_path(conn, :create), jackpot: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.jackpot_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.jackpot_path(conn, :create), jackpot: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update jackpot" do
    setup [:create_jackpot]

    test "renders jackpot when data is valid", %{conn: conn, jackpot: %Jackpot{id: id} = jackpot} do
      conn = put(conn, Routes.jackpot_path(conn, :update, jackpot), jackpot: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.jackpot_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, jackpot: jackpot} do
      conn = put(conn, Routes.jackpot_path(conn, :update, jackpot), jackpot: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete jackpot" do
    setup [:create_jackpot]

    test "deletes chosen jackpot", %{conn: conn, jackpot: jackpot} do
      conn = delete(conn, Routes.jackpot_path(conn, :delete, jackpot))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.jackpot_path(conn, :show, jackpot))
      end
    end
  end

  defp create_jackpot(_) do
    jackpot = jackpot_fixture()
    %{jackpot: jackpot}
  end
end
