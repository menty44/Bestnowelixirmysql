defmodule BestnowelixirmysqlWeb.SmspackageController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Smspackages
  alias Bestnowelixirmysql.Smspackages.Smspackage

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    smspackages = Smspackages.list_smspackages()
    render(conn, "index.json", smspackages: smspackages)
  end

  def create(conn, %{"smspackage" => smspackage_params}) do
    with {:ok, %Smspackage{} = smspackage} <- Smspackages.create_smspackage(smspackage_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.smspackage_path(conn, :show, smspackage))
      |> render("show.json", smspackage: smspackage)
    end
  end

  def show(conn, %{"id" => id}) do
    smspackage = Smspackages.get_smspackage!(id)
    render(conn, "show.json", smspackage: smspackage)
  end

  def update(conn, %{"id" => id, "smspackage" => smspackage_params}) do
    smspackage = Smspackages.get_smspackage!(id)

    with {:ok, %Smspackage{} = smspackage} <- Smspackages.update_smspackage(smspackage, smspackage_params) do
      render(conn, "show.json", smspackage: smspackage)
    end
  end

  def delete(conn, %{"id" => id}) do
    smspackage = Smspackages.get_smspackage!(id)

    with {:ok, %Smspackage{}} <- Smspackages.delete_smspackage(smspackage) do
      send_resp(conn, :no_content, "")
    end
  end
end
