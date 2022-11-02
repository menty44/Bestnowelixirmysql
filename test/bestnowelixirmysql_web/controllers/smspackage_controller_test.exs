defmodule BestnowelixirmysqlWeb.SmspackageControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.SmspackagesFixtures

  alias Bestnowelixirmysql.Smspackages.Smspackage

  @create_attrs %{
    amount: "some amount",
    uid: "some uid"
  }
  @update_attrs %{
    amount: "some updated amount",
    uid: "some updated uid"
  }
  @invalid_attrs %{amount: nil, uid: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all smspackages", %{conn: conn} do
      conn = get(conn, Routes.smspackage_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create smspackage" do
    test "renders smspackage when data is valid", %{conn: conn} do
      conn = post(conn, Routes.smspackage_path(conn, :create), smspackage: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.smspackage_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "some amount",
               "uid" => "some uid"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.smspackage_path(conn, :create), smspackage: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update smspackage" do
    setup [:create_smspackage]

    test "renders smspackage when data is valid", %{conn: conn, smspackage: %Smspackage{id: id} = smspackage} do
      conn = put(conn, Routes.smspackage_path(conn, :update, smspackage), smspackage: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.smspackage_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "some updated amount",
               "uid" => "some updated uid"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, smspackage: smspackage} do
      conn = put(conn, Routes.smspackage_path(conn, :update, smspackage), smspackage: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete smspackage" do
    setup [:create_smspackage]

    test "deletes chosen smspackage", %{conn: conn, smspackage: smspackage} do
      conn = delete(conn, Routes.smspackage_path(conn, :delete, smspackage))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.smspackage_path(conn, :show, smspackage))
      end
    end
  end

  defp create_smspackage(_) do
    smspackage = smspackage_fixture()
    %{smspackage: smspackage}
  end
end
