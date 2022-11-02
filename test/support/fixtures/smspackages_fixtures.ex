defmodule Bestnowelixirmysql.SmspackagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Smspackages` context.
  """

  @doc """
  Generate a smspackage.
  """
  def smspackage_fixture(attrs \\ %{}) do
    {:ok, smspackage} =
      attrs
      |> Enum.into(%{
        amount: "some amount",
        uid: "some uid"
      })
      |> Bestnowelixirmysql.Smspackages.create_smspackage()

    smspackage
  end
end
