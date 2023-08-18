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

  alias Bestnowelixirmysql.Packages
  alias Bestnowelixirmysql.Packages.Package

  import AtEx.Util

  #  use AtEx.Gateway.Base, url: get_url(@live_url, @sandbox_url)

  action_fallback BestnowelixirmysqlWeb.FallbackController

  @live_url "https://api.africastalking.com/version1"
  @sandbox_url "https://api.sandbox.africastalking.com/version1"

  @base_url "http://localhost:3030/api/sms"
  @headers [{"Content-Type", "application/json"}]

  def index(conn, _params) do
    mobile_payments = Payment.list_mobile_payments()
    render(conn, "index.json", mobile_payments: mobile_payments)
  end

  #  defp process_lipanampesa(data) do
  #     Enum.each(data, fn x ->
  #
  #       if x["Name"] == "PhoneNumber" do
  #         IO.inspect(x)
  #         IO.inspect(x["Value"])
  #       end
  #
  #       if x["Name"] == "Amount" do
  #         IO.inspect(x)
  #         IO.inspect(x["Value"])
  #       end
  #
  #       if x["Name"] == "MpesaReceiptNumber" do
  #         IO.inspect(x)
  #         IO.inspect(x["Value"])
  #       end
  #
  #       if x["Name"] == "TransactionDate" do
  #         IO.inspect(x)
  #         IO.inspect(x["Value"])
  #       end
  ##         Payment.process_mobile_payment(x)
  #     end)
  #  end

  def validation(conn, params) do
    params
    #    |> Map.get("Body")
    #    |> Map.get("stkCallback")
    #    |> Map.get("CallbackMetadata")
    #    |> Map.get("Item")
    #    |> process_lipanampesa
    |> IO.inspect()

    conn
    |> put_status(:ok)
    |> json(%{
      data: "noma"
    })
  end

  def validation694949(conn, params) do
    params
    #    |> Map.get("Body")
    #    |> Map.get("stkCallback")
    #    |> Map.get("CallbackMetadata")
    #    |> Map.get("Item")
    #    |> process_lipanampesa
    |> IO.inspect()

    conn
    |> put_status(:ok)
    |> json(%{
      data: "noma"
    })
  end

  def confirmation(conn, params) do
    IO.inspect(params, label: "params 1234")

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

    new_struct |> IO.inspect(label: "new_struct")

    Map.get(new_struct, "msisdn")
    |> IO.inspect()

    process_sms_games(params["MSISDN"], params["TransAmount"])
    |> IO.inspect(label: "process_sms_games noma apa")

    {:ok, mobileuser} =
      Bestnowelixirmysql.Mobileaccounts.get_by_phone!(Map.get(new_struct, "msisdn"))

    Mobileaccounts.update_user_payment(mobileuser) |> IO.inspect(label: "update_user_payment")

    case Bestnowelixirmysql.Subscriptions.find_by_uid!(mobileuser.id) do
      {:ok, subscription} ->
        update_existing_sub(
          subscription.id,
          %{
            "days" => subscription.days + get_package_days(new_struct["transamount"]),
            "active" => true
          },
          mobileuser.phone,
          get_package_struct(new_struct["transamount"])
        )

      {:error, :not_found} ->
        create_new_sub(
          %{
            "uid" => mobileuser.id,
            "days" => get_package_days(new_struct["transamount"]),
            "active" => true
          },
          mobileuser.phone,
          get_package_struct(new_struct["transamount"])
        )

      {:error, _} ->
        create_new_sub(
          %{
            "uid" => mobileuser.id,
            "days" => get_package_days(new_struct["transamount"]),
            "active" => true
          },
          mobileuser.phone,
          get_package_struct(new_struct["transamount"])
        )
    end

    with {:ok, %Payment{} = payment} <- Payments.create_payment(new_struct) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.payment_path(conn, :show, payment))
      |> render("show.json", payment: payment)
    end
  end

  def confirmation694949(conn, params) do
    IO.inspect(params, label: "params 694949")

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

    new_struct |> IO.inspect(label: "new_struct")

    Map.get(new_struct, "msisdn")
    |> IO.inspect()

    process_current_game_amount_by_till_sms(params["MSISDN"], params["TransAmount"])
    |> IO.inspect(label: "process_sms_games noma apa")

    {:ok, mobileuser} =
      Bestnowelixirmysql.Mobileaccounts.get_by_phone!(Map.get(new_struct, "msisdn"))

    Mobileaccounts.update_user_payment(mobileuser) |> IO.inspect(label: "update_user_payment")

    case Bestnowelixirmysql.Subscriptions.find_by_uid!(mobileuser.id) do
      {:ok, subscription} ->
        update_existing_sub(
          subscription.id,
          %{
            "days" => subscription.days + get_package_days(new_struct["transamount"]),
            "active" => true
          },
          mobileuser.phone,
          get_package_struct(new_struct["transamount"])
        )

      {:error, :not_found} ->
        create_new_sub(
          %{
            "uid" => mobileuser.id,
            "days" => get_package_days(new_struct["transamount"]),
            "active" => true
          },
          mobileuser.phone,
          get_package_struct(new_struct["transamount"])
        )

      {:error, _} ->
        create_new_sub(
          %{
            "uid" => mobileuser.id,
            "days" => get_package_days(new_struct["transamount"]),
            "active" => true
          },
          mobileuser.phone,
          get_package_struct(new_struct["transamount"])
        )
    end

    with {:ok, %Payment{} = payment} <- Payments.create_payment(new_struct) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.payment_path(conn, :show, payment))
      |> render("show.json", payment: payment)
    end
  end

  def process_sms_games(phone, amount) do
    amount =
      case amount do
        "50.00" -> process_current_game_amount_by_sms(phone, amount)
        "100.00" -> process_current_game_amount_by_sms(phone, amount)
        "200.00" -> process_current_game_amount_by_sms(phone, amount)
        "300.00" -> process_current_game_amount_by_sms(phone, amount)
        _ -> IO.inspect("Amount belongs to other games kabisa")
      end

    amount |> IO.inspect(label: "update_user_payment check amount")
  end

  def process_sms_till_games(phone, amount) do
    IO.inspect("till games process")

    amount =
      case amount do
        "50.00" -> process_current_game_amount_by_till_sms(phone, amount)
        "100.00" -> process_current_game_amount_by_till_sms(phone, amount)
        "200.00" -> process_current_game_amount_by_till_sms(phone, amount)
        "300.00" -> process_current_game_amount_by_till_sms(phone, amount)
        _ -> IO.inspect("Amount belongs to other games kabisa")
      end

    amount |> IO.inspect(label: "update_user_payment check amount")
  end

  defp process_current_game_amount_by_sms(phone, amount) do
    phone |> IO.inspect(label: "process_current_game_amount_by_sms check phone")
    amount |> IO.inspect(label: "process_current_game_amount_by_sms check amount")

    [game] = Bestnowelixirmysql.Smsgames.get_current_game_by_sms(amount)
    IO.inspect(game, label: "checki")

    url = "https://api.africastalking.com/restless/send"
    username = "B_Best"
    s_code = "B_U"

    apikey = "415a70ee214ada0b735eb5220710732037345975777912560acc2237a5bfdc0d"

    games = URI.encode(game.games)
    IO.inspect(games, label: "games fuck kabisa")

    body = %{
      "phone" => phone,
      "games" => game.games
    }

    res = HTTPoison.post(@base_url, Poison.encode!(body), @headers, [])
    IO.inspect(res, label: "SMS sent")
  end

  defp process_current_game_amount_by_till_sms(phone, amount) do
    phone |> IO.inspect(label: "process_current_game_amount_by_sms check phone")
    amount |> IO.inspect(label: "process_current_game_amount_by_sms check amount")

    [game] = Bestnowelixirmysql.Tillgames.get_current_game_by_sms(amount)
    IO.inspect(game, label: "checki")

    url = "https://api.onfonmedia.co.ke/v1/sms/SendBulkSMS"
        username = "Bestnow"
        s_code = "23984"
        apikey = "GeCEO1iwVWnc7vKrMh04Fmso8jT5faZplHq2tJIxg9uy6Q3b"


    body = %{
      "SenderId" => s_code,
      "IsUnicode" => true,
      "IsFlash" => true,
      "ScheduledateTime" => "0",
      MessageParameters: [
        %{
          "Number" => "254720106420",
          "Text" => game.games
        }
      ],
      Apikey: apikey,
      Clientid: username
    }

    res = HTTPoison.post(url, Poison.encode!(body), @headers, [])
    IO.inspect(res, label: "SMS sent for till")
  end

  def send_sms(phone, name, days) do
    IO.inspect(phone, label: "WW phone")
    IO.inspect(name, label: "WW sub_struct")
    IO.inspect(days, label: "WW days")

    if name == "SMS package" do
      IO.inspect("SMS package no need to process")
    else
      url = "https://api.africastalking.com/restless/send"
      username = "B_Best"
      s_code = "B_U"

      #    apikey = "f69a9ac7e25242e426da5b0f4401a33436aa9ec772a8d7b27050d98349f80fcd"
      apikey = "415a70ee214ada0b735eb5220710732037345975777912560acc2237a5bfdc0d"

      try do
        #      {:ok, mobileuser} = Bestnowelixirmysql.Mobileaccounts.get_by_phone!(phone)
        #      IO.inspect(gen)
        #      Bestnowelixirmysql.Mobileaccounts.update_mobileuser(mobileuser, %{password: gen})

        #        "&message=You%20have%20purchased%20" <> name <> "Package.%20" <> "Available%20days:%20"<> days <>
        complete =
          url <>
            "?username=" <>
            username <>
            "&Apikey=" <>
            apikey <>
            "&to=" <>
            phone <>
            "&message=" <>
            String.upcase(
              "You%20have%20purchased%20" <>
                name <> "%20Package.%20" <> "%20Available%20days%20:%20#{days}"
            ) <>
            "&from=" <>
            s_code

        case HTTPoison.get(complete) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            IO.puts(body)
            {:ok, _xml} = XmlJson.AwsApi.deserialize(body)

          {:error, _} ->
            IO.puts("error")
        end
      rescue
        Ecto.NoResultsError ->
          {:error, :not_found, "No result found"}
      end
    end
  end

  def get_package_days(mpesa_price) do
    {parsed_price, _} = Integer.parse(mpesa_price)
    #    {:ok, package} = Packages.get_by_price!(parsed_price)
    case Packages.get_by_price!(parsed_price) do
      {:ok, package} -> package.duration
      {:error, :not_found} -> 0
    end

    #    package.duration
  end

  def get_package_struct(mpesa_price) do
    {parsed_price, _} = Integer.parse(mpesa_price)
    #    {:ok, package} = Packages.get_by_price!(parsed_price)
    case Packages.get_by_price!(parsed_price) do
      {:ok, package} -> package.name
      {:error, :not_found} -> "SMS package"
    end

    #    package.name
  end

  def update_existing_sub(id, subscription_params, phone, new_struct) do
    IO.inspect(subscription_params, label: "subscription_params")
    IO.inspect(phone, label: "phone")
    IO.inspect(new_struct, label: "new_struct")
    send_sms(phone, new_struct, subscription_params["days"])
    subscription = Subscriptions.get_subscription!(id)
    Subscriptions.update_subscription(subscription, subscription_params)
  end

  def create_new_sub(subscription_params, phone, new_struct) do
    case Subscriptions.create_subscription(subscription_params) do
      {:ok, data} -> send_sms(phone, new_struct, subscription_params["days"])
      {:error, _} -> IO.inspect("not created")
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
