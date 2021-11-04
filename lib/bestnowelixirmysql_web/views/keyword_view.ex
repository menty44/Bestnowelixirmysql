defmodule BestnowelixirmysqlWeb.KeywordView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.KeywordView

  def render("index.json", %{keyword: keyword}) do
    %{data: render_many(keyword, KeywordView, "keyword.json")}
  end

  def render("show.json", %{keyword: keyword}) do
    %{data: render_one(keyword, KeywordView, "keyword.json")}
  end

  def render("keyword.json", %{keyword: keyword}) do
    %{
      id: keyword.id,
      shortcode: keyword.shortcode,
      keyword: keyword.keyword,
      owner: keyword.owner,
      manager: keyword.manager
    }
  end
end
