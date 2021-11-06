defmodule BestnowelixirmysqlWeb.TillControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.PaymentFixtures

  alias Bestnowelixirmysql.Payment.Till

  @create_attrs %{
    BillRefNumber: "some BillRefNumber",
    BusinessShortCode: "some BusinessShortCode",
    FirstName: "some FirstName",
    InvoiceNumber: "some InvoiceNumber",
    LastName: "some LastName",
    MSISDN: "some MSISDN",
    MiddleName: "some MiddleName",
    OrgAccountBalance: "some OrgAccountBalance",
    ThirdPartyTransID: "some ThirdPartyTransID",
    TransAmount: "some TransAmount",
    TransDate: "some TransDate",
    TransID: "some TransID",
    TransTime: "some TransTime",
    TransactionType: "some TransactionType",
    transLoID: 42
  }
  @update_attrs %{
    BillRefNumber: "some updated BillRefNumber",
    BusinessShortCode: "some updated BusinessShortCode",
    FirstName: "some updated FirstName",
    InvoiceNumber: "some updated InvoiceNumber",
    LastName: "some updated LastName",
    MSISDN: "some updated MSISDN",
    MiddleName: "some updated MiddleName",
    OrgAccountBalance: "some updated OrgAccountBalance",
    ThirdPartyTransID: "some updated ThirdPartyTransID",
    TransAmount: "some updated TransAmount",
    TransDate: "some updated TransDate",
    TransID: "some updated TransID",
    TransTime: "some updated TransTime",
    TransactionType: "some updated TransactionType",
    transLoID: 43
  }
  @invalid_attrs %{
    BillRefNumber: nil,
    BusinessShortCode: nil,
    FirstName: nil,
    InvoiceNumber: nil,
    LastName: nil,
    MSISDN: nil,
    MiddleName: nil,
    OrgAccountBalance: nil,
    ThirdPartyTransID: nil,
    TransAmount: nil,
    TransDate: nil,
    TransID: nil,
    TransTime: nil,
    TransactionType: nil,
    transLoID: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tills", %{conn: conn} do
      conn = get(conn, Routes.till_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create till" do
    test "renders till when data is valid", %{conn: conn} do
      conn = post(conn, Routes.till_path(conn, :create), till: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.till_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "BillRefNumber" => "some BillRefNumber",
               "BusinessShortCode" => "some BusinessShortCode",
               "FirstName" => "some FirstName",
               "InvoiceNumber" => "some InvoiceNumber",
               "LastName" => "some LastName",
               "MSISDN" => "some MSISDN",
               "MiddleName" => "some MiddleName",
               "OrgAccountBalance" => "some OrgAccountBalance",
               "ThirdPartyTransID" => "some ThirdPartyTransID",
               "TransAmount" => "some TransAmount",
               "TransDate" => "some TransDate",
               "TransID" => "some TransID",
               "TransTime" => "some TransTime",
               "TransactionType" => "some TransactionType",
               "transLoID" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.till_path(conn, :create), till: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update till" do
    setup [:create_till]

    test "renders till when data is valid", %{conn: conn, till: %Till{id: id} = till} do
      conn = put(conn, Routes.till_path(conn, :update, till), till: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.till_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "BillRefNumber" => "some updated BillRefNumber",
               "BusinessShortCode" => "some updated BusinessShortCode",
               "FirstName" => "some updated FirstName",
               "InvoiceNumber" => "some updated InvoiceNumber",
               "LastName" => "some updated LastName",
               "MSISDN" => "some updated MSISDN",
               "MiddleName" => "some updated MiddleName",
               "OrgAccountBalance" => "some updated OrgAccountBalance",
               "ThirdPartyTransID" => "some updated ThirdPartyTransID",
               "TransAmount" => "some updated TransAmount",
               "TransDate" => "some updated TransDate",
               "TransID" => "some updated TransID",
               "TransTime" => "some updated TransTime",
               "TransactionType" => "some updated TransactionType",
               "transLoID" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, till: till} do
      conn = put(conn, Routes.till_path(conn, :update, till), till: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete till" do
    setup [:create_till]

    test "deletes chosen till", %{conn: conn, till: till} do
      conn = delete(conn, Routes.till_path(conn, :delete, till))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.till_path(conn, :show, till))
      end
    end
  end

  defp create_till(_) do
    till = till_fixture()
    %{till: till}
  end
end
