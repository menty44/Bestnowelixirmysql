defmodule BestnowelixirmysqlWeb.MobileuserController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql
  alias Bestnowelixirmysql.Mobileaccounts.Mobileuser

#  alias Bestnowelixirmysql.Guardian
  alias BestnowelixirmysqlWeb.Auth.Guardian
#  use Guardian, otp_app: :myApi

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    mobileusers = Mobileaccounts.list_mobileusers()
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
           "token" => token
        }
      }
         )
    end
  end

  def reset_password(conn, %{"phone" => phone}) do
    charlist = :io_lib.format("~4..0B", [:rand.uniform(10_000) - 1])
    IO.inspect charlist
    conn
    |> put_status(:ok)
    |> json(%{
          "code" => 0,
#          "charlist" => charlist,
          "gen" => gen_reference
}
      )
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
    with {:ok, %Mobileuser{} = mobileuser} <- Bestnowelixirmysql.Mobileaccounts.create_mobileuser(mobileuser_params) do
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
    mobileuser = Mobileaccounts.get_mobileuser!(id)

    with {:ok, %Mobileuser{} = mobileuser} <- Mobileaccounts.update_mobileuser(mobileuser, mobileuser_params) do
      render(conn, "show.json", mobileuser: mobileuser)
    end
  end

  def delete(conn, %{"id" => id}) do
    mobileuser = Mobileaccounts.get_mobileuser!(id)

    with {:ok, %Mobileuser{}} <- Mobileaccounts.delete_mobileuser(mobileuser) do
      send_resp(conn, :no_content, "")
    end
  end
end
