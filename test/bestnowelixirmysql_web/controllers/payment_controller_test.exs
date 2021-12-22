defmodule BestnowelixirmysqlWeb.PaymentControllerTest do
  use BestnowelixirmysqlWeb.ConnCase

  import Bestnowelixirmysql.PaymentsFixtures

  alias Bestnowelixirmysql.Payments.Payment

  @create_attrs %{
    billrefnumber: "some billrefnumber",
    businessshortcode: "some businessshortcode",
    firstname: "some firstname",
    invoicenumber: "some invoicenumber",
    lastname: "some lastname",
    middlename: "some middlename",
    msisdn: "some msisdn",
    orgaccountbalance: "some orgaccountbalance",
    thirdpartytransid: "some thirdpartytransid",
    transactiontype: "some transactiontype",
    transamount: "some transamount",
    transid: "some transid",
    transtime: "some transtime"
  }
  @update_attrs %{
    billrefnumber: "some updated billrefnumber",
    businessshortcode: "some updated businessshortcode",
    firstname: "some updated firstname",
    invoicenumber: "some updated invoicenumber",
    lastname: "some updated lastname",
    middlename: "some updated middlename",
    msisdn: "some updated msisdn",
    orgaccountbalance: "some updated orgaccountbalance",
    thirdpartytransid: "some updated thirdpartytransid",
    transactiontype: "some updated transactiontype",
    transamount: "some updated transamount",
    transid: "some updated transid",
    transtime: "some updated transtime"
  }
  @invalid_attrs %{billrefnumber: nil, businessshortcode: nil, firstname: nil, invoicenumber: nil, lastname: nil, middlename: nil, msisdn: nil, orgaccountbalance: nil, thirdpartytransid: nil, transactiontype: nil, transamount: nil, transid: nil, transtime: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all payments", %{conn: conn} do
      conn = get(conn, Routes.payment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create payment" do
    test "renders payment when data is valid", %{conn: conn} do
      conn = post(conn, Routes.payment_path(conn, :create), payment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.payment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "billrefnumber" => "some billrefnumber",
               "businessshortcode" => "some businessshortcode",
               "firstname" => "some firstname",
               "invoicenumber" => "some invoicenumber",
               "lastname" => "some lastname",
               "middlename" => "some middlename",
               "msisdn" => "some msisdn",
               "orgaccountbalance" => "some orgaccountbalance",
               "thirdpartytransid" => "some thirdpartytransid",
               "transactiontype" => "some transactiontype",
               "transamount" => "some transamount",
               "transid" => "some transid",
               "transtime" => "some transtime"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.payment_path(conn, :create), payment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update payment" do
    setup [:create_payment]

    test "renders payment when data is valid", %{conn: conn, payment: %Payment{id: id} = payment} do
      conn = put(conn, Routes.payment_path(conn, :update, payment), payment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.payment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "billrefnumber" => "some updated billrefnumber",
               "businessshortcode" => "some updated businessshortcode",
               "firstname" => "some updated firstname",
               "invoicenumber" => "some updated invoicenumber",
               "lastname" => "some updated lastname",
               "middlename" => "some updated middlename",
               "msisdn" => "some updated msisdn",
               "orgaccountbalance" => "some updated orgaccountbalance",
               "thirdpartytransid" => "some updated thirdpartytransid",
               "transactiontype" => "some updated transactiontype",
               "transamount" => "some updated transamount",
               "transid" => "some updated transid",
               "transtime" => "some updated transtime"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, payment: payment} do
      conn = put(conn, Routes.payment_path(conn, :update, payment), payment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete payment" do
    setup [:create_payment]

    test "deletes chosen payment", %{conn: conn, payment: payment} do
      conn = delete(conn, Routes.payment_path(conn, :delete, payment))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.payment_path(conn, :show, payment))
      end
    end
  end

  defp create_payment(_) do
    payment = payment_fixture()
    %{payment: payment}
  end
end
