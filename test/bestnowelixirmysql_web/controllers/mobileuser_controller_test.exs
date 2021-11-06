defmodule BestnowelixirmysqlWeb.MobileuserControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.MobileaccountsFixtures

  alias Bestnowelixirmysql.Mobileaccounts.Mobileuser

  @create_attrs %{
    firstname: "some firstname",
    lastname: "some lastname",
    password_hash: "some password_hash",
    phone: "some phone"
  }
  @update_attrs %{
    firstname: "some updated firstname",
    lastname: "some updated lastname",
    password_hash: "some updated password_hash",
    phone: "some updated phone"
  }
  @invalid_attrs %{firstname: nil, lastname: nil, password_hash: nil, phone: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all mobileusers", %{conn: conn} do
      conn = get(conn, Routes.mobileuser_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create mobileuser" do
    test "renders mobileuser when data is valid", %{conn: conn} do
      conn = post(conn, Routes.mobileuser_path(conn, :create), mobileuser: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.mobileuser_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "firstname" => "some firstname",
               "lastname" => "some lastname",
               "password_hash" => "some password_hash",
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.mobileuser_path(conn, :create), mobileuser: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update mobileuser" do
    setup [:create_mobileuser]

    test "renders mobileuser when data is valid", %{
      conn: conn,
      mobileuser: %Mobileuser{id: id} = mobileuser
    } do
      conn =
        put(conn, Routes.mobileuser_path(conn, :update, mobileuser), mobileuser: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.mobileuser_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "firstname" => "some updated firstname",
               "lastname" => "some updated lastname",
               "password_hash" => "some updated password_hash",
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, mobileuser: mobileuser} do
      conn =
        put(conn, Routes.mobileuser_path(conn, :update, mobileuser), mobileuser: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete mobileuser" do
    setup [:create_mobileuser]

    test "deletes chosen mobileuser", %{conn: conn, mobileuser: mobileuser} do
      conn = delete(conn, Routes.mobileuser_path(conn, :delete, mobileuser))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.mobileuser_path(conn, :show, mobileuser))
      end
    end
  end

  defp create_mobileuser(_) do
    mobileuser = mobileuser_fixture()
    %{mobileuser: mobileuser}
  end
end
