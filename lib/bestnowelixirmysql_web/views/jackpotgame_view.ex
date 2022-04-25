defmodule BestnowelixirmysqlWeb.JackpotgameView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.JackpotgameView

  def render("index.json", %{jackpotgames: jackpotgames}) do
    %{data: render_many(jackpotgames, JackpotgameView, "jackpotgame.json")}
  end

  def render("show.json", %{jackpotgame: jackpotgame}) do
    %{data: render_one(jackpotgame, JackpotgameView, "jackpotgame.json")}
  end

  def render("jackpotgame.json", %{jackpotgame: jackpotgame}) do
    %{
      id: jackpotgame.id,
      time: jackpotgame.time,
      league: jackpotgame.league,
      match: jackpotgame.match,
      tip: jackpotgame.tip,
      results: jackpotgame.results
    }
  end
end
