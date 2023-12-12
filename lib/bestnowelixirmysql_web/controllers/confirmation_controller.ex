defmodule BestnowelixirmysqlWeb.ConfirmationController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Confirmations
  alias Bestnowelixirmysql.Confirmations.Confirmation

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    confirmations = Confirmations.list_confirmations()
    render(conn, "index.json", confirmations: confirmations)
  end

  def create(conn, %{"confirmation" => confirmation_params}) do
    with {:ok, %Confirmation{} = confirmation} <- Confirmations.create_confirmation(confirmation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.confirmation_path(conn, :show, confirmation))
      |> render("show.json", confirmation: confirmation)
    end
  end

  def show(conn, %{"id" => id}) do
    confirmation = Confirmations.get_confirmation!(id)
    render(conn, "show.json", confirmation: confirmation)
  end

  def update(conn, %{"id" => id, "confirmation" => confirmation_params}) do
    confirmation = Confirmations.get_confirmation!(id)

    with {:ok, %Confirmation{} = confirmation} <- Confirmations.update_confirmation(confirmation, confirmation_params) do
      render(conn, "show.json", confirmation: confirmation)
    end
  end

  def delete(conn, %{"id" => id}) do
    confirmation = Confirmations.get_confirmation!(id)

    with {:ok, %Confirmation{}} <- Confirmations.delete_confirmation(confirmation) do
      send_resp(conn, :no_content, "")
    end
  end
end
