defmodule Bestnowelixirmysql.BookmakersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Bookmakers` context.
  """

  @doc """
  Generate a bookmaker.
  """
  def bookmaker_fixture(attrs \\ %{}) do
    {:ok, bookmaker} =
      attrs
      |> Enum.into(%{
        games: "some games",
        keyword: "some keyword",
        loadingdate: "some loadingdate",
        owner: "some owner",
        shortcode: "some shortcode"
      })
      |> Bestnowelixirmysql.Bookmakers.create_bookmaker()

    bookmaker
  end
end
