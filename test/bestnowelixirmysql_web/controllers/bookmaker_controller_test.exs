defmodule BestnowelixirmysqlWeb.BookmakerControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.BookmakersFixtures

  alias Bestnowelixirmysql.Bookmakers.Bookmaker

  @create_attrs %{
    games: "some games",
    keyword: "some keyword",
    loadingdate: "some loadingdate",
    owner: "some owner",
    shortcode: "some shortcode"
  }
  @update_attrs %{
    games: "some updated games",
    keyword: "some updated keyword",
    loadingdate: "some updated loadingdate",
    owner: "some updated owner",
    shortcode: "some updated shortcode"
  }
  @invalid_attrs %{games: nil, keyword: nil, loadingdate: nil, owner: nil, shortcode: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bookmakers", %{conn: conn} do
      conn = get(conn, Routes.bookmaker_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bookmaker" do
    test "renders bookmaker when data is valid", %{conn: conn} do
      conn = post(conn, Routes.bookmaker_path(conn, :create), bookmaker: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.bookmaker_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "games" => "some games",
               "keyword" => "some keyword",
               "loadingdate" => "some loadingdate",
               "owner" => "some owner",
               "shortcode" => "some shortcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.bookmaker_path(conn, :create), bookmaker: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bookmaker" do
    setup [:create_bookmaker]

    test "renders bookmaker when data is valid", %{
      conn: conn,
      bookmaker: %Bookmaker{id: id} = bookmaker
    } do
      conn = put(conn, Routes.bookmaker_path(conn, :update, bookmaker), bookmaker: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.bookmaker_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "games" => "some updated games",
               "keyword" => "some updated keyword",
               "loadingdate" => "some updated loadingdate",
               "owner" => "some updated owner",
               "shortcode" => "some updated shortcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bookmaker: bookmaker} do
      conn = put(conn, Routes.bookmaker_path(conn, :update, bookmaker), bookmaker: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bookmaker" do
    setup [:create_bookmaker]

    test "deletes chosen bookmaker", %{conn: conn, bookmaker: bookmaker} do
      conn = delete(conn, Routes.bookmaker_path(conn, :delete, bookmaker))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.bookmaker_path(conn, :show, bookmaker))
      end
    end
  end

  defp create_bookmaker(_) do
    bookmaker = bookmaker_fixture()
    %{bookmaker: bookmaker}
  end
end
