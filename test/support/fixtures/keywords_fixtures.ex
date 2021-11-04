defmodule Bestnowelixirmysql.KeywordsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Keywords` context.
  """

  @doc """
  Generate a keyword.
  """
  def keyword_fixture(attrs \\ %{}) do
    {:ok, keyword} =
      attrs
      |> Enum.into(%{
        keyword: "some keyword",
        manager: "some manager",
        owner: "some owner",
        shortcode: "some shortcode"
      })
      |> Bestnowelixirmysql.Keywords.create_keyword()

    keyword
  end
end
