defmodule BestnowelixirmysqlWeb.GameView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.GameView

  def render("index.json", %{games: games}) do
    %{data: render_many(games, GameView, "game.json")}
  end

  def render("show.json", %{game: game}) do
    %{data: render_one(game, GameView, "game.json")}
  end

  def render("game.json", %{game: game}) do
    %{
      id: game.id,
      time: game.time,
      league: game.league,
      match: game.match,
      tip: game.tip,
      results: game.results
    }
  end
end
