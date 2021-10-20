defmodule Bestnowelixirmysql.PaymentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Payment` context.
  """

  @doc """
  Generate a mobilepayments.
  """
  def mobilepayments_fixture(attrs \\ %{}) do
    {:ok, mobilepayments} =
      attrs
      |> Enum.into(%{
        BusinessShortCode: "some BusinessShortCode",
        FirstName: "some FirstName",
        LastName: "some LastName",
        MSISDN: "some MSISDN",
        MiddleName: "some MiddleName",
        OrgAccountBalance: "some OrgAccountBalance",
        TransAmount: "some TransAmount",
        TransID: "some TransID",
        TransTime: "some TransTime",
        transLoID: 42
      })
      |> Bestnowelixirmysql.Payment.create_mobilepayments()

    mobilepayments
  end
end
