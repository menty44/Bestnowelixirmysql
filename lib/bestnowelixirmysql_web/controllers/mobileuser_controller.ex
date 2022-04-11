defmodule BestnowelixirmysqlWeb.MobileuserController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql
  alias Bestnowelixirmysql.Mobileaccounts.Mobileuser

  #  alias Bestnowelixirmysql.Guardian
  alias BestnowelixirmysqlWeb.Auth.Guardian
  #  use Guardian, otp_app: :myApi

  alias Bestnowelixirmysql.Africastalkingtexts
  alias Bestnowelixirmysql.Africastalkingtexts.Africastalkingtext

  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Keywords

  alias Bestnowelixirmysql.Africastalkingtexts
  alias Bestnowelixirmysql.Africastalkingtexts.Africastalkingtext

  require Phoenix.Logger
  action_fallback BestnowelixirmysqlWeb.FallbackController

  alias Bestnowelixirmysql.Packages
  alias Bestnowelixirmysql.Packages.Package

  def index(conn, _params) do
    mobileusers = Bestnowelixirmysql.Mobileaccounts.list_mobileusers()
    render(conn, "index.json", mobileusers: mobileusers)
  end

  #  def create(conn, %{"user" => user_params}) do
  #    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
  #         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
  #      # snip
  #    end
  #  end

  def signin(conn, %{"phone" => phone, "password" => password}) do
    IO.inspect(" --- login Payload ---")
    IO.inspect(phone)
    IO.inspect(password)

    with {:ok, mobileuser, token} <- Guardian.authenticate(phone, password) do
      IO.inspect(mobileuser.firstname)

      conn
      |> put_status(:ok)
      |> json(%{
        "code" => 0,
        "user" => %{
          "firstname" => mobileuser.firstname,
          "lastname" => mobileuser.lastname,
          "phone" => mobileuser.phone,
          "role" => mobileuser.role,
          "mode" => mobileuser.mode,
          "token" => token
        }
      })

    else
      :error ->
        {:error, :invalid_credentials}
        IO.inspect(:error)

      _ ->
        conn
        |> put_status(500)
        |> json(%{
          "code" => 3,
          "message" => "error occured"
        })
    end
  end

  def phone_number(conn, params) do
    IO.inspect(" --- phone_number Payload ---")
    IO.inspect(params)
    IO.inspect(Map.get(params, "phone"))
    # get data from phone number
    with {:ok, mobileuser} <-
           Bestnowelixirmysql.Mobileaccounts.get_by_phone!(Map.get(params, "phone")) do
      IO.inspect(mobileuser.firstname)
      IO.inspect(mobileuser.lastname)
      IO.inspect(mobileuser.phone)
      IO.inspect(mobileuser.id)
      render(conn, "show.json", mobileuser: mobileuser)
    end
  end

  def reset_password(conn, %{"number" => phone}) do
    IO.inspect(phone)
    #    _charlist = :io_lib.format("~6..0B", [:rand.uniform(10_000) - 1])
    gen = gen_reference()
    url = "https://api.africastalking.com/restless/send"
    username = "B_Best"
    s_code = "B_U"

#    apikey = "f69a9ac7e25242e426da5b0f4401a33436aa9ec772a8d7b27050d98349f80fcd"
    apikey = "415a70ee214ada0b735eb5220710732037345975777912560acc2237a5bfdc0d"

    try do
      {:ok, mobileuser} = Bestnowelixirmysql.Mobileaccounts.get_by_phone!(phone)
      IO.inspect(gen)
      Bestnowelixirmysql.Mobileaccounts.update_mobileuser(mobileuser, %{password: gen})

      complete =
        url <>
          "?username=" <>
          username <>
          "&Apikey=" <>
          apikey <>
          "&to=" <>
          phone <>
          "&message=Your%20temporary%20password%20is%3A%20" <>
          gen <>
          "&from=" <>
          s_code


      case HTTPoison.get(complete) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          IO.puts(body)
          {:ok, xml} = XmlJson.AwsApi.deserialize(body)
          demo = xml
          africastalkingtext_saved = save_africastalkingtext(demo, gen)
          IO.inspect(africastalkingtext_saved)

          conn
          |> put_status(:ok)
          |> json(%{
            "code" => 0,
            "message" => "Your temporary password is: " <> gen
          })

        {:error, _} ->
          conn
          |> put_status(:ok)
          |> json(%{
            "code" => 3,
            "message" => "error occured"
          })
      end
    rescue
      Ecto.NoResultsError ->
        {:error, :not_found, "No result found"}

        conn
        |> put_status(:ok)
        |> json(%{
          "code" => 3,
          "message" => "error occured"
        })
    end
  end

  defp save_africastalkingtext(demo, gen) do
    IO.inspect(demo)

    IO.inspect(demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"],
      label: "checki parent"
    )

    IO.inspect(
      demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["cost"],
      label: "cost"
    )

    IO.inspect(
      demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["messageId"],
      label: "messageId"
    )

    IO.inspect(
      demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["messageParts"],
      label: "messageParts"
    )

    IO.inspect(
      demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["number"],
      label: "number"
    )

    IO.inspect(
      demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["status"],
      label: "status"
    )

    IO.inspect(
      demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["statusCode"],
      label: "statusCode"
    )

    africastalkingtext_params = %{
      sentmessage: "Your temporary password is: " <> gen,
      messageId:
        demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["messageId"],
      cost: demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["cost"],
      messageParts:
        demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"][
          "messageParts"
        ],
      number:
        demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["number"],
      status:
        demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["status"],
      statusCode:
        demo["AfricasTalkingResponse"]["SMSMessageData"]["Recipients"]["Recipient"]["statusCode"]
    }

    with {:ok, %Africastalkingtext{} = africastalkingtext} <-
           Africastalkingtexts.create_africastalkingtext(africastalkingtext_params) do
      IO.inspect(africastalkingtext)
      {:ok, africastalkingtext}
    end
  end

  defp gen_reference() do
    min = String.to_integer("100000", 3)
    max = String.to_integer("ZZZZZZ", 36)

    max
    |> Kernel.-(min)
    |> :rand.uniform()
    |> Kernel.+(min)
    |> Integer.to_string(36)
  end

  def create(conn, %{"mobileuser" => mobileuser_params}) do
    with {:ok, %Mobileuser{} = mobileuser} <-
           Bestnowelixirmysql.Mobileaccounts.create_mobileuser(mobileuser_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.mobileuser_path(conn, :show, mobileuser))
      |> render("show.json", mobileuser: mobileuser)
    end
  end

  def show(conn, %{"id" => id}) do
    mobileuser = Mobileaccounts.get_mobileuser!(id)
    render(conn, "show.json", mobileuser: mobileuser)
  end

  def update(conn, %{"id" => id, "mobileuser" => mobileuser_params}) do
    mobileuser = Bestnowelixirmysql.Mobileaccounts.get_mobileuser!(id)
    IO.inspect(mobileuser)

    with {:ok, %Mobileuser{} = mobileuser} <-
           Bestnowelixirmysql.Mobileaccounts.update_mobileuser(mobileuser, mobileuser_params) do
      render(conn, "show.json", mobileuser: mobileuser)
    end
  end

  def update(conn, %{"id" => id, "deactivate" => mobileuser_params}) do
    IO.inspect(mobileuser_params, label: "deactivate")
    mobileuser = Bestnowelixirmysql.Mobileaccounts.get_mobileuser!(id)
    IO.inspect(mobileuser)
    IO.inspect(mobileuser_params)

    with {:ok, %Mobileuser{} = mobileuser} <-
           Bestnowelixirmysql.Mobileaccounts.update_mobileuser(mobileuser, %{
             mode: Map.get(mobileuser_params, "mode")
           }) do
      render(conn, "show.json", mobileuser: mobileuser)
    end
  end

  def update(conn, %{"id" => id, "activate" => mobileuser_params}) do
    IO.inspect(mobileuser_params, label: "activate")
    mobileuser = Bestnowelixirmysql.Mobileaccounts.get_mobileuser!(id)
    IO.inspect(mobileuser)
    IO.inspect(mobileuser_params)

    with {:ok, %Mobileuser{} = mobileuser} <-
           Bestnowelixirmysql.Mobileaccounts.update_mobileuser(mobileuser, %{
             mode: Map.get(mobileuser_params, "mode")
           }) do
      render(conn, "show.json", mobileuser: mobileuser)
    end
  end

  def delete(conn, %{"id" => id}) do
    mobileuser = Mobileaccounts.get_mobileuser!(id)

    with {:ok, %Mobileuser{}} <- Mobileaccounts.delete_mobileuser(mobileuser) do
      send_resp(conn, :no_content, "")
    end
  end

  def report(conn, _) do
    mobile_users = Bestnowelixirmysql.Mobileaccounts.count_by_id!()
    book_makers = Bestnowelixirmysql.Bookmakers.count_by_id!()
    packages = Bestnowelixirmysql.Packages.count_by_id!()
    kw = Keywords.count_by_id!()
    reset_pass_sms = Africastalkingtexts.count_by_id!()

    conn
    |> put_status(:ok)
    |> json(%{
      mobile_users: mobile_users,
      book_makers: book_makers,
      kw: kw,
      packages: packages,
      reset_pass_sms: reset_pass_sms
    })
  end

  def manual(conn, params) do

    {:ok, mobile_user} =
      Bestnowelixirmysql.Mobileaccounts.create_mobileuser(params["mobileuser"])
      |> IO.inspect(label: "data")

    mobile_user.id |> IO.inspect(label: "data.id")

    with {:ok, %Mobileuser{} = mobileuser} <- Bestnowelixirmysql.Mobileaccounts.update_mobileuser(params, %{
             mode: "activated"
           }) do IO.inspect(mobileuser)  end

    case Bestnowelixirmysql.Subscriptions.find_by_uid!(mobileuser.id) do
      {:ok, subscription} -> update_existing_sub(subscription.id, %{"days" => subscription.days + get_package_days(new_struct["transamount"]), "active" => true}, mobileuser.phone, get_package_struct(new_struct["transamount"]))
      {:error, :not_found} -> create_new_sub(%{"uid" => mobileuser.id, "days" => get_package_days(new_struct["transamount"]), "active" => true}, mobileuser.phone, get_package_struct(new_struct["transamount"]))
      {:error, _} -> create_new_sub(%{"uid" => mobileuser.id, "days" => get_package_days(new_struct["transamount"]), "active" => true}, mobileuser.phone, get_package_struct(new_struct["transamount"]))
    end

    conn
    |> json(params)
  end


  def get_package_days(mpesa_price) do
    {parsed_price, _} = Integer.parse(mpesa_price)
    {:ok, package} = Packages.get_by_price!(parsed_price)
    package.duration
  end

  def get_package_struct(mpesa_price) do
    {parsed_price, _} = Integer.parse(mpesa_price)
    {:ok, package} = Packages.get_by_price!(parsed_price)
    package.name
  end

  def update_existing_sub(id, subscription_params, phone, new_struct) do
    IO.inspect subscription_params, label: "subscription_params"
    IO.inspect phone, label: "phone"
    IO.inspect new_struct, label: "new_struct"
    send_sms(phone, new_struct, subscription_params["days"])
    subscription = Subscriptions.get_subscription!(id)
    Subscriptions.update_subscription(subscription, subscription_params)

  end

  def create_new_sub(subscription_params,phone, new_struct) do
    case Subscriptions.create_subscription(subscription_params) do
      {:ok, data} -> send_sms(phone, new_struct, subscription_params["days"])
      {:error, _} -> IO.inspect "not created"
    end
  end
end
