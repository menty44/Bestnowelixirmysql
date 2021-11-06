defmodule BestnowelixirmysqlWeb.InfosControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.BetFixtures

  alias Bestnowelixirmysql.Bet.Infos

  @create_attrs %{
    date_added: ~D[2021-10-19],
    keyword: "some keyword",
    messages: "some messages",
    shortcode: 42
  }
  @update_attrs %{
    date_added: ~D[2021-10-20],
    keyword: "some updated keyword",
    messages: "some updated messages",
    shortcode: 43
  }
  @invalid_attrs %{date_added: nil, keyword: nil, messages: nil, shortcode: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all info", %{conn: conn} do
      conn = get(conn, Routes.infos_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create infos" do
    test "renders infos when data is valid", %{conn: conn} do
      conn = post(conn, Routes.infos_path(conn, :create), infos: @create_attrs)
      assert %{"info_id" => info_id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.infos_path(conn, :show, info_id))

      assert %{
               "info_id" => ^info_id,
               "date_added" => "2021-10-19",
               "keyword" => "some keyword",
               "messages" => "some messages",
               "shortcode" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.infos_path(conn, :create), infos: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update infos" do
    setup [:create_infos]

    test "renders infos when data is valid", %{
      conn: conn,
      infos: %Infos{info_id: info_id} = infos
    } do
      conn = put(conn, Routes.infos_path(conn, :update, infos), infos: @update_attrs)
      assert %{"info_id" => ^info_id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.infos_path(conn, :show, info_id))

      assert %{
               "info_id" => ^info_id,
               "date_added" => "2021-10-20",
               "keyword" => "some updated keyword",
               "messages" => "some updated messages",
               "shortcode" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, infos: infos} do
      conn = put(conn, Routes.infos_path(conn, :update, infos), infos: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete infos" do
    setup [:create_infos]

    test "deletes chosen infos", %{conn: conn, infos: infos} do
      conn = delete(conn, Routes.infos_path(conn, :delete, infos))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.infos_path(conn, :show, infos))
      end
    end
  end

  defp create_infos(_) do
    infos = infos_fixture()
    %{infos: infos}
  end
end
