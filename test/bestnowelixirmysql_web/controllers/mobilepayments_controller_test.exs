defmodule BestnowelixirmysqlWeb.MobilepaymentsControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.PaymentFixtures

  alias Bestnowelixirmysql.Payment.Mobilepayments

  @create_attrs %{
    BusinessShortCode: "some BusinessShortCode",
    FirstName: "some FirstName",
    LastName: "some LastName",
    MSISDN: "some MSISDN",
    MiddleName: "some MiddleName",
    OrgAccountBalance: "some OrgAccountBalance",
    TransAmount: "some TransAmount",
    TransID: "some TransID",
    TransTime: "some TransTime",
    transLoID: 42
  }
  @update_attrs %{
    BusinessShortCode: "some updated BusinessShortCode",
    FirstName: "some updated FirstName",
    LastName: "some updated LastName",
    MSISDN: "some updated MSISDN",
    MiddleName: "some updated MiddleName",
    OrgAccountBalance: "some updated OrgAccountBalance",
    TransAmount: "some updated TransAmount",
    TransID: "some updated TransID",
    TransTime: "some updated TransTime",
    transLoID: 43
  }
  @invalid_attrs %{BusinessShortCode: nil, FirstName: nil, LastName: nil, MSISDN: nil, MiddleName: nil, OrgAccountBalance: nil, TransAmount: nil, TransID: nil, TransTime: nil, transLoID: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all mobile_payments", %{conn: conn} do
      conn = get(conn, Routes.mobilepayments_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create mobilepayments" do
    test "renders mobilepayments when data is valid", %{conn: conn} do
      conn = post(conn, Routes.mobilepayments_path(conn, :create), mobilepayments: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.mobilepayments_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "BusinessShortCode" => "some BusinessShortCode",
               "FirstName" => "some FirstName",
               "LastName" => "some LastName",
               "MSISDN" => "some MSISDN",
               "MiddleName" => "some MiddleName",
               "OrgAccountBalance" => "some OrgAccountBalance",
               "TransAmount" => "some TransAmount",
               "TransID" => "some TransID",
               "TransTime" => "some TransTime",
               "transLoID" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.mobilepayments_path(conn, :create), mobilepayments: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update mobilepayments" do
    setup [:create_mobilepayments]

    test "renders mobilepayments when data is valid", %{conn: conn, mobilepayments: %Mobilepayments{id: id} = mobilepayments} do
      conn = put(conn, Routes.mobilepayments_path(conn, :update, mobilepayments), mobilepayments: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.mobilepayments_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "BusinessShortCode" => "some updated BusinessShortCode",
               "FirstName" => "some updated FirstName",
               "LastName" => "some updated LastName",
               "MSISDN" => "some updated MSISDN",
               "MiddleName" => "some updated MiddleName",
               "OrgAccountBalance" => "some updated OrgAccountBalance",
               "TransAmount" => "some updated TransAmount",
               "TransID" => "some updated TransID",
               "TransTime" => "some updated TransTime",
               "transLoID" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, mobilepayments: mobilepayments} do
      conn = put(conn, Routes.mobilepayments_path(conn, :update, mobilepayments), mobilepayments: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete mobilepayments" do
    setup [:create_mobilepayments]

    test "deletes chosen mobilepayments", %{conn: conn, mobilepayments: mobilepayments} do
      conn = delete(conn, Routes.mobilepayments_path(conn, :delete, mobilepayments))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.mobilepayments_path(conn, :show, mobilepayments))
      end
    end
  end

  defp create_mobilepayments(_) do
    mobilepayments = mobilepayments_fixture()
    %{mobilepayments: mobilepayments}
  end
end
