defmodule BestnowelixirmysqlWeb.AfricastalkingtextController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Africastalkingtexts
  alias Bestnowelixirmysql.Africastalkingtexts.Africastalkingtext

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    africastalkingtexts = Africastalkingtexts.list_africastalkingtexts()
    render(conn, "index.json", africastalkingtexts: africastalkingtexts)
  end

  def create(conn, %{"africastalkingtext" => africastalkingtext_params}) do
    with {:ok, %Africastalkingtext{} = africastalkingtext} <- Africastalkingtexts.create_africastalkingtext(africastalkingtext_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.africastalkingtext_path(conn, :show, africastalkingtext))
      |> render("show.json", africastalkingtext: africastalkingtext)
    end
  end

  def show(conn, %{"id" => id}) do
    africastalkingtext = Africastalkingtexts.get_africastalkingtext!(id)
    render(conn, "show.json", africastalkingtext: africastalkingtext)
  end

  def update(conn, %{"id" => id, "africastalkingtext" => africastalkingtext_params}) do
    africastalkingtext = Africastalkingtexts.get_africastalkingtext!(id)

    with {:ok, %Africastalkingtext{} = africastalkingtext} <- Africastalkingtexts.update_africastalkingtext(africastalkingtext, africastalkingtext_params) do
      render(conn, "show.json", africastalkingtext: africastalkingtext)
    end
  end

  def delete(conn, %{"id" => id}) do
    africastalkingtext = Africastalkingtexts.get_africastalkingtext!(id)

    with {:ok, %Africastalkingtext{}} <- Africastalkingtexts.delete_africastalkingtext(africastalkingtext) do
      send_resp(conn, :no_content, "")
    end
  end
end
