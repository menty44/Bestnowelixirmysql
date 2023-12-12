defmodule BestnowelixirmysqlWeb.ConfirmationControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.ConfirmationsFixtures

  alias Bestnowelixirmysql.Confirmations.Confirmation

  @create_attrs %{
    amount: "some amount",
    mpesacode: "some mpesacode",
    phone: "some phone"
  }
  @update_attrs %{
    amount: "some updated amount",
    mpesacode: "some updated mpesacode",
    phone: "some updated phone"
  }
  @invalid_attrs %{amount: nil, mpesacode: nil, phone: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all confirmations", %{conn: conn} do
      conn = get(conn, Routes.confirmation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create confirmation" do
    test "renders confirmation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.confirmation_path(conn, :create), confirmation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.confirmation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "some amount",
               "mpesacode" => "some mpesacode",
               "phone" => "some phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.confirmation_path(conn, :create), confirmation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update confirmation" do
    setup [:create_confirmation]

    test "renders confirmation when data is valid", %{conn: conn, confirmation: %Confirmation{id: id} = confirmation} do
      conn = put(conn, Routes.confirmation_path(conn, :update, confirmation), confirmation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.confirmation_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "amount" => "some updated amount",
               "mpesacode" => "some updated mpesacode",
               "phone" => "some updated phone"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, confirmation: confirmation} do
      conn = put(conn, Routes.confirmation_path(conn, :update, confirmation), confirmation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete confirmation" do
    setup [:create_confirmation]

    test "deletes chosen confirmation", %{conn: conn, confirmation: confirmation} do
      conn = delete(conn, Routes.confirmation_path(conn, :delete, confirmation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.confirmation_path(conn, :show, confirmation))
      end
    end
  end

  defp create_confirmation(_) do
    confirmation = confirmation_fixture()
    %{confirmation: confirmation}
  end
end
