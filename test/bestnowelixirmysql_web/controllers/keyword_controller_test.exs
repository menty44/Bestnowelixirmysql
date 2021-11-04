defmodule BestnowelixirmysqlWeb.KeywordControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.KeywordsFixtures

  alias Bestnowelixirmysql.Keywords.Keyword

  @create_attrs %{
    keyword: "some keyword",
    manager: "some manager",
    owner: "some owner",
    shortcode: "some shortcode"
  }
  @update_attrs %{
    keyword: "some updated keyword",
    manager: "some updated manager",
    owner: "some updated owner",
    shortcode: "some updated shortcode"
  }
  @invalid_attrs %{keyword: nil, manager: nil, owner: nil, shortcode: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all keyword", %{conn: conn} do
      conn = get(conn, Routes.keyword_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create keyword" do
    test "renders keyword when data is valid", %{conn: conn} do
      conn = post(conn, Routes.keyword_path(conn, :create), keyword: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.keyword_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "keyword" => "some keyword",
               "manager" => "some manager",
               "owner" => "some owner",
               "shortcode" => "some shortcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.keyword_path(conn, :create), keyword: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update keyword" do
    setup [:create_keyword]

    test "renders keyword when data is valid", %{conn: conn, keyword: %Keyword{id: id} = keyword} do
      conn = put(conn, Routes.keyword_path(conn, :update, keyword), keyword: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.keyword_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "keyword" => "some updated keyword",
               "manager" => "some updated manager",
               "owner" => "some updated owner",
               "shortcode" => "some updated shortcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, keyword: keyword} do
      conn = put(conn, Routes.keyword_path(conn, :update, keyword), keyword: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete keyword" do
    setup [:create_keyword]

    test "deletes chosen keyword", %{conn: conn, keyword: keyword} do
      conn = delete(conn, Routes.keyword_path(conn, :delete, keyword))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.keyword_path(conn, :show, keyword))
      end
    end
  end

  defp create_keyword(_) do
    keyword = keyword_fixture()
    %{keyword: keyword}
  end
end
