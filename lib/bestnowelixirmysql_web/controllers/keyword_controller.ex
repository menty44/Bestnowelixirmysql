defmodule BestnowelixirmysqlWeb.KeywordController do
  use BestnowelixirmysqlWeb, :controller

  alias Bestnowelixirmysql.Keywords
  alias Bestnowelixirmysql.Keywords.Keyword

  action_fallback BestnowelixirmysqlWeb.FallbackController

  def index(conn, _params) do
    keyword = Keywords.list_keyword()
    render(conn, "index.json", keyword: keyword)
  end

  def create(conn, %{"keyword" => keyword_params}) do
    with {:ok, %Keyword{} = keyword} <- Keywords.create_keyword(keyword_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.keyword_path(conn, :show, keyword))
      |> render("show.json", keyword: keyword)
    end
  end

  def show(conn, %{"id" => id}) do
    keyword = Keywords.get_keyword!(id)
    render(conn, "show.json", keyword: keyword)
  end

  def update(conn, %{"id" => id, "keyword" => keyword_params}) do
    keyword = Keywords.get_keyword!(id)

    with {:ok, %Keyword{} = keyword} <- Keywords.update_keyword(keyword, keyword_params) do
      render(conn, "show.json", keyword: keyword)
    end
  end

  def delete(conn, %{"id" => id}) do
    keyword = Keywords.get_keyword!(id)

    with {:ok, %Keyword{}} <- Keywords.delete_keyword(keyword) do
      send_resp(conn, :no_content, "")
    end
  end
end
