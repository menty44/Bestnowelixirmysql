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
    {a, b} = keyword
    render(conn, "show.json", keyword: b)
  end

  def update(conn, %{"id" => id, "keyword" => keyword_params}) do
    keyword = Keywords.get_keyword!(id)
    {a, b} = keyword

    with {:ok, %Keyword{} = keyword} <- Keywords.update_keyword(b, keyword_params) do
      render(conn, "show.json", keyword: keyword)
    end
  end

  defp gracefully_handle_get(nil) do
    {:error, :not_found}
  end

  defp gracefully_handle_get(keyword) do
    {:ok, keyword}
  end

  def delete(conn, %{"id" => id}) do
    keyword = Keywords.get_keyword!(id)

    {a, b} = keyword
    IO.inspect(b, label: "keyword")

    case keyword do
      {:ok, _} ->
        Keywords.delete_keyword!(b)

        conn
        |> put_status(:ok)
        |> json(%{
          "message" => "record deleted"
        })

      _ ->
        {:error, :not_found}

        conn
        |> put_status(500)
        |> json(%{
          "code" => 3,
          "message" => "id not found"
        })
    end
  end
end
