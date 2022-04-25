defmodule BestnowelixirmysqlWeb.JackpotView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.JackpotView

  def render("index.json", %{jackpots: jackpots}) do
    %{data: render_many(jackpots, JackpotView, "jackpot.json")}
  end

  def render("show.json", %{jackpot: jackpot}) do
    %{data: render_one(jackpot, JackpotView, "jackpot.json")}
  end

  def render("jackpot.json", %{jackpot: jackpot}) do
    %{
      id: jackpot.id,
      name: jackpot.name
    }
  end
end
