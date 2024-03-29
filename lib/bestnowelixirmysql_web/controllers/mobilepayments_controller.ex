defmodule BestnowelixirmysqlWeb.MobilepaymentsController do
  use BestnowelixirmysqlWeb, :controller
  use HTTPoison.Base

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

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Confirmations.Confirmation

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

  def generate_mpesa_token do
    url = "https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials"
    headers = [
      {"Authorization", "Basic YUtrcnF3ZkpBSnNnMUFzNlpwQlRTZXlBSlBPYmlMVXg6bGU1RFFMczF3OEZ0YkZQSw=="}
    ]

    response = get(url, headers)

    case response do
      {:ok, %{status_code: 200, body: body}} -> get_phone_number_from_callback(Poison.decode!(body))
      {:ok, %{status_code: code, body: body}} ->
        IO.puts "Unexpected response. Status code: #{code}, Body: #{body}"
      {:error, reason} ->
        IO.puts "Failed to generate token. Reason: #{reason}"
    end
  end

  def get_phone_number_from_callback(token) do
    IO.inspect(token)
  end

  def getphone(conn,  params = %{"Result" => %{"ConversationID" => conversationid, "OriginatorConversationID" => originatorid, "ReferenceData" => %{"ReferenceItem" => %{"Key" => ocasionkey, "Value" => refvalue}}, "ResultCode" => resultcode, "ResultDesc" => resdescription, "ResultParameters" => %{"ResultParameter" => [%{"Key" => debitpartyname, "Value" => myuser}, %{"Key" => _, "Value" => _}, %{"Key" => "OriginatorConversationID"}, %{"Key" => "InitiatedTime", "Value" => _}, %{"Key" => "CreditPartyCharges"}, %{"Key" => "DebitAccountType", "Value" => _}, %{"Key" => "TransactionReason"}, %{"Key" => "ReasonType", "Value" => "Pay Merchant"}, %{"Key" => "TransactionStatus", "Value" => "Completed"}, %{"Key" => "FinalisedTime", "Value" => _}, %{"Key" => "Amount", "Value" => useramount}, %{"Key" => "ConversationID"}, %{"Key" => "ReceiptNo", "Value" => mpesacode}]}, "ResultType" => 0, "TransactionID" => transid}}) do
    IO.inspect(params, label: "mpesa get PHONE")

    IO.inspect(myuser, label: "get my phone before")
    [phone,fullname] = myuser |> String.trim |> String.split "-"

    finalphone = phone |> String.trim
    IO.inspect(finalphone, label: "get my phone after")

    IO.inspect(useramount, label: "get my amount")
    IO.inspect(mpesacode, label: "get my mpesacode")

    latest_preprocess_mpesa(conn, %{"phone" => finalphone, "mpesacode" => mpesacode, "amount" => useramount}) |> IO.inspect

    conn
    |> put_status(200)
    |> json(%{
      "message" => "processed"
    })
  end

  def latest_preprocess_mpesa(conn, checker = %{"phone" => phone, "mpesacode" => mpesacode, "amount" => amount}) do
    "checker +++++++++++++++++++++++++++++++++++++++++++++++++=" |> IO.inspect

    checker |> IO.inspect
    # Check if the record already exists
    existing_record = Bestnowelixirmysql.Confirmations.filter_by_code!(mpesacode)
    existing_record |> IO.inspect label: "------------- existing_record -------------------"
    case existing_record do
      "not found" ->
        # Record doesn't exist, so save it
        new_record_params = %{
          amount: Float.to_string(amount) <> "0",  # replace with the actual amount
          phone: phone,
          mpesacode: mpesacode
        }

#        new_record = Bestnowelixirmysql.Confirmations.Confirmation.changeset(%Bestnowelixirmysql.Confirmations.Confirmation{}, new_record_params)
        new_record_params |> IO.inspect label: "new_record_params ######## before save"
        newphone = if String.starts_with?(phone, "0") do
              Regex.replace(~r/^0/, phone, "254")
            else
              phone
            end
            newphone |> IO.inspect label: "newphnumber"
#        process_sms_games(newphone, Float.to_string(amount) <> "0")
        process_sms_till_games(newphone, Float.to_string(amount) <> "0")
          case Bestnowelixirmysql.Confirmations.create_confirmation(new_record_params) do
          {:ok, inserted_record} -> inserted_record |> IO.inspect
          {:error, changeset} -> changeset |> IO.inspect
          _ -> nil
        end
      _ ->
      IO.inspect "niko nil"
      nil
    end
  end

  def confirmation694949(conn, params) do
    %{"access_token" => access_token, "expires_in" => _} = generate_mpesa_token()
    access_token |> IO.inspect(label: "mpesa token")

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

    mpesa_url = "https://api.safaricom.co.ke/mpesa/transactionstatus/v1/query"
    mpesa_result_url = "https://api.forebetweb.com/api/getphone"
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer " <> access_token}
    ]

    body = %{
      "Initiator" => "webapi",
      "SecurityCredential" => "IC4GTxwfA+Dodw5icCGRYrzXhCDu0Jp2CPhEG7mL/Yvbfo6jCsS04MJGAo5G7M+nR7FDoZjuPy4PI5wWE0/tJD1HsKxCahx9OeHod04RRATvyZDkz3sRj0aFF9gcullAzzSaBxyeSom7kd3CN5EHetv60HhwSlJ9vEdqRir0yhxB5caDJ30X3hDCUmtn6hMFVkPATxQmVM8bvXSEWl49kCFitoxqVWT9PuIv7tW1ae6c7cctqTibjiGbSnHCObpx4YygucE5s0XercIZulFduYoyxvlrCcBRuhwfpAyRr6oFdFz9z8VnpGhaI5jU6F0CnCChTX/AeNeGozYiJRnN8Q==",
      "CommandID" => "TransactionStatusQuery",
      "TransactionID" => params["TransID"],
      "OriginalConcersationID" => "",
      "PartyA" => "893422",
      "IdentifierType" => "4",
      "ResultURL" => mpesa_result_url,
      "QueueTimeOutURL" => "https://paybill.forebetweb.com/api/v1/users/callback/validation",
      "Remarks" => "Check Payment Status",
      "Occasion" => "OK"
    }

    response = post!(mpesa_url, Poison.encode!(body), headers)

    # Handle the response accordingly
    IO.inspect response

#    process_current_game_amount_by_till_sms(params["MSISDN"], params["TransAmount"])
#    |> IO.inspect(label: "process_sms_games noma apa")
#
#    {:ok, mobileuser} =
#      Bestnowelixirmysql.Mobileaccounts.get_by_phone!(Map.get(new_struct, "msisdn"))
#
#    Mobileaccounts.update_user_payment(mobileuser) |> IO.inspect(label: "update_user_payment")

#    case Bestnowelixirmysql.Subscriptions.find_by_uid!(mobileuser.id) do
#      {:ok, subscription} ->
#        update_existing_sub(
#          subscription.id,
#          %{
#            "days" => subscription.days + get_package_days(new_struct["transamount"]),
#            "active" => true
#          },
#          mobileuser.phone,
#          get_package_struct(new_struct["transamount"])
#        )
#
#      {:error, :not_found} ->
#        create_new_sub(
#          %{
#            "uid" => mobileuser.id,
#            "days" => get_package_days(new_struct["transamount"]),
#            "active" => true
#          },
#          mobileuser.phone,
#          get_package_struct(new_struct["transamount"])
#        )
#
#      {:error, _} ->
#        create_new_sub(
#          %{
#            "uid" => mobileuser.id,
#            "days" => get_package_days(new_struct["transamount"]),
#            "active" => true
#          },
#          mobileuser.phone,
#          get_package_struct(new_struct["transamount"])
#        )
#    end
#    get_package_struct(new_struct["transamount"])
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

    parsed_token = parse_json_string(get_jwt_onfone())
    IO.inspect parsed_token["token"]


#    start send sms onfone
    url = "https://apis.onfonmedia.co.ke/v2_send"
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer " <> parsed_token["token"]},
    ]

    payload = %{
      "to" => phone,
      "from" => "BTNUMBER",
      "content" => game.games,
      "dlr" => "yes",
      "dlr-url" => "http://192.168.202.54/dlr_receiver.php",
      "dlr-level" => 1
    }

    response = post(url, Poison.encode!(payload), headers)

    case response do
      {:ok, body} -> body
#        IO.puts "Message sent successfully. Response: #{body}"
      {:ok, %{status_code: code, body: body}} ->
        IO.puts "Unexpected response. Status code: #{code}, Body: #{body}"
      {:error, reason} ->
        IO.puts "Failed to send message. Reason: #{reason}"
    end
#    end send sms onfone




#    url = "https://api.africastalking.com/restless/send"
#    username = "B_Best"
#    s_code = "B_U"
#
#    apikey = "415a70ee214ada0b735eb5220710732037345975777912560acc2237a5bfdc0d"
#
#    games = URI.encode(game.games)
#    IO.inspect(games, label: "games fuck kabisa")
#
#    body = %{
#      "phone" => phone,
#      "games" => game.games
#    }
#
#    res = HTTPoison.post(@base_url, Poison.encode!(body), @headers, [])
#    IO.inspect(res, label: "SMS sent")
  end

  def get_jwt_onfone() do
    url = "https://apis.onfonmedia.co.ke/v1/authorization"
    headers = [
      {"Content-Type", "application/json"}
    ]

    payload = %{
      "apiUsername" => "bestnownumber",
      "apiPassword" => "AazPvFXJW1x9byDBfYpoN5S8QViT24UH6qmhIs30lGEwe7Cd"
    }

    response = post(url, Poison.encode!(payload), headers)

    case response do
      {:ok, %{status_code: 200, body: body}} -> body
#        IO.puts "Access token retrieved successfully. Response: #{body}"
      {:ok, %{status_code: code, body: body}} ->
        IO.puts "Unexpected response. Status code: #{code}, Body: #{body}"
      {:error, reason} ->
        IO.puts "Failed to retrieve access token. Reason: #{reason}"
    end

  end

  def parse_json_string(json_string) do
    case Poison.decode(json_string) do
      {:ok, map} ->
        IO.inspect(map)
      {:error, reason} ->
        IO.puts "Failed to parse JSON: #{reason}"
    end
  end

  defp process_current_game_amount_by_till_sms(phone, amount) do
    phone |> IO.inspect(label: "process_current_game_amount_by_sms check phone till x")
    amount |> IO.inspect(label: "process_current_game_amount_by_sms check amount till x")

    [game] = Bestnowelixirmysql.Tillgames.get_current_game_by_sms(amount)
    IO.inspect(game, label: "checki 123")

    parsed_token = parse_json_string(get_jwt_onfone())
    IO.inspect parsed_token["token"]


    #    start send sms onfone
    url = "https://apis.onfonmedia.co.ke/v2_send"
    headers = [
      {"Content-Type", "application/json"},
      {"Authorization", "Bearer " <> parsed_token["token"]},
    ]

    payload = %{
      "to" => phone,
      "from" => "BTNUMBER",
      "content" => game.games,
      "dlr" => "yes",
      "dlr-url" => "http://192.168.202.54/dlr_receiver.php",
      "dlr-level" => 1
    }

    response = post(url, Poison.encode!(payload), headers)

    case response do
      {:ok, body} -> body
      #        IO.puts "Message sent successfully. Response: #{body}"
      {:ok, %{status_code: code, body: body}} ->
        IO.puts "Unexpected response. Status code: #{code}, Body: #{body}"
      {:error, reason} ->
        IO.puts "Failed to send message. Reason: #{reason}"
    end
    #    end send sms onfone

#    url = "https://api.onfonmedia.co.ke/v1/sms/SendBulkSMS"
#        username = "Bestnow"
#        s_code = "23984"
#        apikey = "GeCEO1iwVWnc7vKrMh04Fmso8jT5faZplHq2tJIxg9uy6Q3b"
#
#
#    body = %{
#      "SenderId" => s_code,
#      "IsUnicode" => true,
#      "IsFlash" => true,
#      "ScheduledateTime" => "0",
#      MessageParameters: [
#        %{
#          "Number" => phone,
#          "Text" => game.games
#        }
#      ],
#      Apikey: apikey,
#      Clientid: username
#    }
#
#    res = HTTPoison.post(url, Poison.encode!(body), @headers, [])
#
#    case res do
#      {:ok, %HTTPoison.Response{body: body}} ->
#
#        IO.inspect(body, label: "XXXX body for 694949 XXXX")
#
#      {:error, %HTTPoison.Error{reason: reason}} ->
#        IO.puts("Request failed: #{reason}")
#        nil
#    end

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
#    send_sms(phone, new_struct, subscription_params["days"])
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
