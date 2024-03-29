defmodule BestnowelixirmysqlWeb.PaymentController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Payments
  alias Bestnowelixirmysql.Payments.Payment

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, params) do
    payments =
      Payments.list_payments(
        convert_to_int(Map.get(params, "page")),
        convert_to_int(Map.get(params, "size"))
      )

    render(conn, "index.json", payments: payments)
  end

  def by_msisdn(conn, params) do
    payments =
      Payments.phone_list_payments(
        Map.get(params, "msisdn"),
        convert_to_int(Map.get(params, "page")),
        convert_to_int(Map.get(params, "size"))
      )

    render(conn, "index.json", payments: payments)
  end

  def convert_to_int(x) do
    String.to_integer(x)
  end

  def create(conn, %{"payment" => payment_params}) do
    with {:ok, %Payment{} = payment} <- Payments.create_payment(payment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.payment_path(conn, :show, payment))
      |> render("show.json", payment: payment)
    end
  end

  def show(conn, %{"id" => id}) do
    payment = Payments.get_payment!(id)
    render(conn, "show.json", payment: payment)
  end

  def update(conn, %{"id" => id, "payment" => payment_params}) do
    payment = Payments.get_payment!(id)

    with {:ok, %Payment{} = payment} <- Payments.update_payment(payment, payment_params) do
      render(conn, "show.json", payment: payment)
    end
  end

  def delete(conn, %{"id" => id}) do
    payment = Payments.get_payment!(id)

    with {:ok, %Payment{}} <- Payments.delete_payment(payment) do
      send_resp(conn, :no_content, "")
    end
  end
end
