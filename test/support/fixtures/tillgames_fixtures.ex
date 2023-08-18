defmodule Bestnowelixirmysql.TillgamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Tillgames` context.
  """

  @doc """
  Generate a tillgame.
  """
  def tillgame_fixture(attrs \\ %{}) do
    {:ok, tillgame} =
      attrs
      |> Enum.into(%{
        amount: "some amount",
        games: "some games"
      })
      |> Bestnowelixirmysql.Tillgames.create_tillgame()

    tillgame
  end
end
