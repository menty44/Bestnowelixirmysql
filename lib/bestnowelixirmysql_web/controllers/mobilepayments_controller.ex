defmodule BestnowelixirmysqlWeb.MobilepaymentsController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Payment
  alias Bestnowelixirmysql.Payment.Mobilepayments

  alias Bestnowelixirmysql.Payments
  alias Bestnowelixirmysql.Payments.Payment

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    mobile_payments = Payment.list_mobile_payments()
    render(conn, "index.json", mobile_payments: mobile_payments)
  end

  defp process_lipanampesa(data) do
     Enum.each(data, fn x ->

       if x["Name"] == "PhoneNumber" do
         IO.inspect(x)
         IO.inspect(x["Value"])
       end

       if x["Name"] == "Amount" do
         IO.inspect(x)
         IO.inspect(x["Value"])
       end

       if x["Name"] == "MpesaReceiptNumber" do
         IO.inspect(x)
         IO.inspect(x["Value"])
       end

       if x["Name"] == "TransactionDate" do
         IO.inspect(x)
         IO.inspect(x["Value"])
       end
#         Payment.process_mobile_payment(x)
     end)
  end

  def validation(conn, params) do
    params
#    |> Map.get("Body")
#    |> Map.get("stkCallback")
#    |> Map.get("CallbackMetadata")
#    |> Map.get("Item")
#    |> process_lipanampesa
    |> IO.inspect

    conn
    |> put_status(:ok)
    |> json(%{
      data: "noma"
    })
  end

  def confirmation(conn, params) do
    IO.inspect params
    new_struct = %{
      "billrefnumber" => params["BillRefNumber"],
      "businessshortcode" => params["BusinessShortCode"],
      "firstname" => params["FirstName"],
      "invoicenumber" => params["InvoiceNumber"],
      "lastname" => params["LastName"],
      "msisdn" => params["MSISDN"],
      "middlename" => params["MiddleName"],
      "orgaccountbalance" => params["OrgAccountBalance"],
      "thirdpartytransid" => params["ThirdPartyTransID"],
      "transamount" => params["TransAmount"],
      "transid" => params["TransID"],
      "transtime" => params["TransTime"],
      "transactiontype" => params["TransactionType"]
    }
                 |> IO.inspect
    with {:ok, %Payment{} = payment} <- Payments.create_payment(new_struct) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.payment_path(conn, :show, payment))
      |> render("show.json", payment: payment)

    end
  end

  def create(conn, %{"mobilepayments" => mobilepayments_params}) do
    with {:ok, %Mobilepayments{} = mobilepayments} <-
           Payment.create_mobilepayments(mobilepayments_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.mobilepayments_path(conn, :show, mobilepayments))
      |> render("show.json", mobilepayments: mobilepayments)
    end
  end

  def show(conn, %{"transLoID" => transLoID}) do
    mobilepayments = Payment.get_mobilepayments!(transLoID)
    render(conn, "show.json", mobilepayments: mobilepayments)
  end

  def update(conn, %{"transLoID" => transLoID, "mobilepayments" => mobilepayments_params}) do
    mobilepayments = Payment.get_mobilepayments!(transLoID)

    with {:ok, %Mobilepayments{} = mobilepayments} <-
           Payment.update_mobilepayments(mobilepayments, mobilepayments_params) do
      render(conn, "show.json", mobilepayments: mobilepayments)
    end
  end

  def delete(conn, %{"transLoID" => transLotransLoID}) do
    mobilepayments = Payment.get_mobilepayments!(transLotransLoID)

    with {:ok, %Mobilepayments{}} <- Payment.delete_mobilepayments(mobilepayments) do
      send_resp(conn, :no_content, "")
    end
  end
end
