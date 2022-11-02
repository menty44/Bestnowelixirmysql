defmodule Bestnowelixirmysql.SmsgamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Smsgames` context.
  """

  @doc """
  Generate a smsgame.
  """
  def smsgame_fixture(attrs \\ %{}) do
    {:ok, smsgame} =
      attrs
      |> Enum.into(%{
        amount: "some amount",
        games: "some games"
      })
      |> Bestnowelixirmysql.Smsgames.create_smsgame()

    smsgame
  end
end
