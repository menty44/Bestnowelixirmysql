defmodule Bestnowelixirmysql.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Games` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        league: "some league",
        match: "some match",
        results: "some results",
        time: "some time",
        tip: "some tip"
      })
      |> Bestnowelixirmysql.Games.create_game()

    game
  end
end
