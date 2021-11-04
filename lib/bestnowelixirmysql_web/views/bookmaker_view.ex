defmodule BestnowelixirmysqlWeb.BookmakerView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.BookmakerView

  def render("index.json", %{bookmakers: bookmakers}) do
    %{data: render_many(bookmakers, BookmakerView, "bookmaker.json")}
  end

  def render("show.json", %{bookmaker: bookmaker}) do
    %{data: render_one(bookmaker, BookmakerView, "bookmaker.json")}
  end

  def render("bookmaker.json", %{bookmaker: bookmaker}) do
    %{
      id: bookmaker.id,
      shortcode: bookmaker.shortcode,
      games: bookmaker.games,
      loadingdate: bookmaker.loadingdate,
      owner: bookmaker.owner,
      keyword: bookmaker.keyword
    }
  end
end
