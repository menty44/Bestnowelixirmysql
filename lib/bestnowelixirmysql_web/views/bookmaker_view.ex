defmodule BestnowelixirmysqlWeb.BookmakerView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.BookmakerView
  alias BestnowelixirmysqlWeb.GameView
  use JsonView

  def render("index.json", %{bookmakers: bookmakers}) do
    %{data: render_many(bookmakers, BookmakerView, "bookmaker.json")}
  end

  def render("show.json", %{bookmaker: bookmaker}) do
    %{data: render_one(bookmaker, BookmakerView, "bookmaker.json")}
  end

  def render("show_all.json", %{bookmaker: bookmaker}) do
  #    data = bookmaker
  #    |> Map.merge(
  #         render_relationship(bookmaker, [
  ##           {:author, MyBlogWeb.UserView, "user.json"},
  #           {:game, GameView, "game.json"},
  #         ])
  #       )
         #render_one(game, GameView, "game.json")
  #    data = render("bookmaker.json",%{bookmaker: bookmaker})
  #    |> render_many(bookmaker.games, GameView, "game.json")
  #    render_json(bookmaker, [game: GameView]
  #    )
#    IO.inspect(bookmaker)
    %{
      id: bookmaker.id,
      games: Enum.map(bookmaker, fn(game) -> message_json(%{game: game}) end),
    }
  end

  def message_json(%{game: game}) do
    IO.inspect game

    %{
      id: game.id,
      time: game.time,
      league: game.league,
      match: game.match,
      tip: game.tip,
      results: game.results
    }
  end
#  def render("game.json", %{game: game}) do
#    %{
#      id: game.id,
#      time: game.time,
#      league: game.league,
#      match: game.match,
#      tip: game.tip,
#      results: game.results
#    }
#  end

  defp render_relationship(struct, relationships) do
    Enum.map(relationships, fn {field, view, template} ->
      {field, render_relationship(Map.get(struct, field), view, template)}
    end)
    |> Enum.into(%{})
  end

  defp render_relationship(%Ecto.Association.NotLoaded{}, _, _), do: nil

  defp render_relationship(relations, view, template) when is_list(relations) do
    render_many(relations, view, template)
  end

  defp render_relationship(relation, view, template) do
    render_one(relation, view, template)
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
