defmodule BestnowelixirmysqlWeb.PaybillController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Payment
  alias Bestnowelixirmysql.Payment.Paybill

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    paybill = Payment.list_paybill()
    render(conn, "index.json", paybill: paybill)
  end

  def create(conn, %{"paybill" => paybill_params}) do
    with {:ok, %Paybill{} = paybill} <- Payment.create_paybill(paybill_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.paybill_path(conn, :show, paybill))
      |> render("show.json", paybill: paybill)
    end
  end

  def show(conn, %{"transLoID" => transLoID}) do
    paybill = Payment.get_paybill!(transLoID)
    render(conn, "show.json", paybill: paybill)
  end

  def update(conn, %{"transLoID" => transLoID, "paybill" => paybill_params}) do
    paybill = Payment.get_paybill!(transLoID)

    with {:ok, %Paybill{} = paybill} <- Payment.update_paybill(paybill, paybill_params) do
      render(conn, "show.json", paybill: paybill)
    end
  end

  def delete(conn, %{"transLoID" => transLoID}) do
    paybill = Payment.get_paybill!(transLoID)

    with {:ok, %Paybill{}} <- Payment.delete_paybill(paybill) do
      send_resp(conn, :no_content, "")
    end
  end

  def transactions(conn, %{"number" => number}) do
    {:ok, paybill} = Payment.paybill_by_phone!(number)
    {:ok, till} = Payment.till_by_phone!(number)
    render(conn, "phone.json", %{paybill: paybill, till: till})
  end
end
