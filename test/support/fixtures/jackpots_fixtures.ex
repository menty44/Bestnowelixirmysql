defmodule Bestnowelixirmysql.JackpotsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Jackpots` context.
  """

  @doc """
  Generate a jackpot.
  """
  def jackpot_fixture(attrs \\ %{}) do
    {:ok, jackpot} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Bestnowelixirmysql.Jackpots.create_jackpot()

    jackpot
  end
end
