defmodule Bestnowelixirmysql.ConfirmationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Confirmations` context.
  """

  @doc """
  Generate a confirmation.
  """
  def confirmation_fixture(attrs \\ %{}) do
    {:ok, confirmation} =
      attrs
      |> Enum.into(%{
        amount: "some amount",
        mpesacode: "some mpesacode",
        phone: "some phone"
      })
      |> Bestnowelixirmysql.Confirmations.create_confirmation()

    confirmation
  end
end
