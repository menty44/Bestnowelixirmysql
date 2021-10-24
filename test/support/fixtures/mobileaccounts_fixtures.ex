defmodule Bestnowelixirmysql.MobileaccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Mobileaccounts` context.
  """

  @doc """
  Generate a mobileuser.
  """
  def mobileuser_fixture(attrs \\ %{}) do
    {:ok, mobileuser} =
      attrs
      |> Enum.into(%{
        firstname: "some firstname",
        lastname: "some lastname",
        password_hash: "some password_hash",
        phone: "some phone"
      })
      |> Bestnowelixirmysql.Mobileaccounts.create_mobileuser()

    mobileuser
  end
end
