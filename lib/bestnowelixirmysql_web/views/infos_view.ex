defmodule BestnowelixirmysqlWeb.InfosView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.InfosView

  def render("index.json", %{info: info}) do
    %{data: render_many(info, InfosView, "infos.json")}
  end

  def render("show.json", %{infos: infos}) do
    %{data: render_one(infos, InfosView, "infos.json")}
  end

  def render("infos.json", %{infos: infos}) do
    %{
      info_id: infos.info_id,
      keyword: infos.keyword,
      shortcode: infos.shortcode,
      messages: infos.messages,
      date_added: infos.date_added
    }
  end
end
