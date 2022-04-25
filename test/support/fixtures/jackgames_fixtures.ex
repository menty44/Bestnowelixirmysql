defmodule Bestnowelixirmysql.JackgamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Jackgames` context.
  """

  @doc """
  Generate a jackpotgame.
  """
  def jackpotgame_fixture(attrs \\ %{}) do
    {:ok, jackpotgame} =
      attrs
      |> Enum.into(%{
        league: "some league",
        match: "some match",
        results: "some results",
        time: "some time",
        tip: "some tip"
      })
      |> Bestnowelixirmysql.Jackgames.create_jackpotgame()

    jackpotgame
  end
end
