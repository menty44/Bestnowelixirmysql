defmodule BestnowelixirmysqlWeb.MobilepaymentsController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Payment
  alias Bestnowelixirmysql.Payment.Mobilepayments

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    mobile_payments = Payment.list_mobile_payments()
    render(conn, "index.json", mobile_payments: mobile_payments)
  end

  def stk conn, params do
    conn
    |> put_status(:ok)
    |> json(%{
      data: "noma"
    })
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
