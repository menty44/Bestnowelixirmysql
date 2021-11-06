defmodule BestnowelixirmysqlWeb.AfricastalkingtextControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.AfricastalkingtextsFixtures

  alias Bestnowelixirmysql.Africastalkingtexts.Africastalkingtext

  @create_attrs %{
    cost: "some cost",
    messageId: "some messageId",
    messageParts: 42,
    number: 42,
    sentmessage: "some sentmessage",
    status: "some status",
    statusCode: 42
  }
  @update_attrs %{
    cost: "some updated cost",
    messageId: "some updated messageId",
    messageParts: 43,
    number: 43,
    sentmessage: "some updated sentmessage",
    status: "some updated status",
    statusCode: 43
  }
  @invalid_attrs %{
    cost: nil,
    messageId: nil,
    messageParts: nil,
    number: nil,
    sentmessage: nil,
    status: nil,
    statusCode: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all africastalkingtexts", %{conn: conn} do
      conn = get(conn, Routes.africastalkingtext_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create africastalkingtext" do
    test "renders africastalkingtext when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.africastalkingtext_path(conn, :create),
          africastalkingtext: @create_attrs
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.africastalkingtext_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "cost" => "some cost",
               "messageId" => "some messageId",
               "messageParts" => 42,
               "number" => 42,
               "sentmessage" => "some sentmessage",
               "status" => "some status",
               "statusCode" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.africastalkingtext_path(conn, :create),
          africastalkingtext: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update africastalkingtext" do
    setup [:create_africastalkingtext]

    test "renders africastalkingtext when data is valid", %{
      conn: conn,
      africastalkingtext: %Africastalkingtext{id: id} = africastalkingtext
    } do
      conn =
        put(conn, Routes.africastalkingtext_path(conn, :update, africastalkingtext),
          africastalkingtext: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.africastalkingtext_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "cost" => "some updated cost",
               "messageId" => "some updated messageId",
               "messageParts" => 43,
               "number" => 43,
               "sentmessage" => "some updated sentmessage",
               "status" => "some updated status",
               "statusCode" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      africastalkingtext: africastalkingtext
    } do
      conn =
        put(conn, Routes.africastalkingtext_path(conn, :update, africastalkingtext),
          africastalkingtext: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete africastalkingtext" do
    setup [:create_africastalkingtext]

    test "deletes chosen africastalkingtext", %{
      conn: conn,
      africastalkingtext: africastalkingtext
    } do
      conn = delete(conn, Routes.africastalkingtext_path(conn, :delete, africastalkingtext))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.africastalkingtext_path(conn, :show, africastalkingtext))
      end
    end
  end

  defp create_africastalkingtext(_) do
    africastalkingtext = africastalkingtext_fixture()
    %{africastalkingtext: africastalkingtext}
  end
end
