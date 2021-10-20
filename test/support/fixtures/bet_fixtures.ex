defmodule Bestnowelixirmysql.BetFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Bet` context.
  """

  @doc """
  Generate a infos.
  """
  def infos_fixture(attrs \\ %{}) do
    {:ok, infos} =
      attrs
      |> Enum.into(%{
        date_added: ~D[2021-10-19],
        keyword: "some keyword",
        messages: "some messages",
        shortcode: 42
      })
      |> Bestnowelixirmysql.Bet.create_infos()

    infos
  end
end
