defmodule BestnowelixirmysqlWeb.MobilepaymentsController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Payment
  alias Bestnowelixirmysql.Payment.Mobilepayments

  alias Bestnowelixirmysql.Payments
  alias Bestnowelixirmysql.Payments.Payment

  alias Bestnowelixirmysql.Accounts
  alias Bestnowelixirmysql.Accounts.User

  alias Bestnowelixirmysql
  alias Bestnowelixirmysql.Mobileaccounts
  alias Bestnowelixirmysql.Mobileaccounts.Mobileuser

  alias Bestnowelixirmysql.Subscriptions
  alias Bestnowelixirmysql.Subscriptions.Subscription

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

    {:ok, data} = Bestnowelixirmysql.Mobileaccounts.get_by_phone! new_struct["msisdn"]
    IO.inspect data, label: "data"

    uid = Bestnowelixirmysql.Subscriptions.find_by_uid!(data.id)
    IO.inspect uid, label: "uid"
    {:ok, sub_id} = uid
    IO.inspect sub_id.id, label: "sub_id"

#    {:ok, sub} = Bestnowelixirmysql.Subscriptions.get_by_id!(sub_id.id)
    days_add = sub_id.days + 35
    IO.inspect days_add, label: "days_add"

#    {:ok, sub} = Bestnowelixirmysql.Subscriptions.update_days!(sub_id.id, days_add)
    case uid do
      {:ok, subscription} -> update_existing_sub(sub_id.id, %{"days" => days_add, "active" => true})
      {:error, error} -> IO.inspect error, label: "error"
      {:error, _} -> create_new_sub(%{"uid" => data.id, "days" => 2})
    end

    with {:ok, %Payment{} = payment} <- Payments.create_payment(new_struct) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.payment_path(conn, :show, payment))
      |> render("show.json", payment: payment)

    end
  end

  def update_existing_sub(id, subscription_params) do
    subscription = Subscriptions.get_subscription!(id)
    Subscriptions.update_subscription(subscription, subscription_params)
  end

  def create_new_sub(subscription_params) do
    case Subscriptions.create_subscription(subscription_params) do
      {:ok, data} -> IO.inspect data, label: "data"
      {:error, _} -> IO.inspect "not created"
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
