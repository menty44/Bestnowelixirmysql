defmodule Bestnowelixirmysql.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        firstname: "some firstname",
        lastname: "some lastname",
        password_hash: "some password_hash",
        phone: "some phone"
      })
      |> Bestnowelixirmysql.Accounts.create_user()

    user
  end
end
