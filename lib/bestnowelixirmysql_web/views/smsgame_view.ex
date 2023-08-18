defmodule BestnowelixirmysqlWeb.SmsgameView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.SmsgameView

  def render("index.json", %{smsgames: smsgames}) do
    %{data: render_many(smsgames, SmsgameView, "smsgame.json")}
  end

  def render("show.json", %{smsgame: smsgame}) do
    %{data: render_one(smsgame, SmsgameView, "smsgame.json")}
  end

  def render("smsgame.json", %{smsgame: smsgame}) do
    %{
      id: smsgame.id,
      amount: smsgame.amount,
      games: smsgame.games,
      commence: smsgame.commence
    }
  end
end
