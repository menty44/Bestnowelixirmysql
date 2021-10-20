defmodule BestnowelixirmysqlWeb.TillController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Payment
  alias Bestnowelixirmysql.Payment.Till

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    tills = Payment.list_tills()
    render(conn, "index.json", tills: tills)
  end

  def create(conn, %{"till" => till_params}) do
    with {:ok, %Till{} = till} <- Payment.create_till(till_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.till_path(conn, :show, till))
      |> render("show.json", till: till)
    end
  end

  def show(conn, %{"transLoID" => transLoID}) do
    till = Payment.get_till!(transLoID)
    render(conn, "show.json", till: till)
  end

  def update(conn, %{"transLoID" => transLoID, "till" => till_params}) do
    till = Payment.get_till!(transLoID)

    with {:ok, %Till{} = till} <- Payment.update_till(till, till_params) do
      render(conn, "show.json", till: till)
    end
  end

  def delete(conn, %{"transLoID" => transLoID}) do
    till = Payment.get_till!(transLoID)

    with {:ok, %Till{}} <- Payment.delete_till(till) do
      send_resp(conn, :no_content, "")
    end
  end
end
