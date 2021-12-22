defmodule Bestnowelixirmysql.PaymentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Payments` context.
  """

  @doc """
  Generate a payment.
  """
  def payment_fixture(attrs \\ %{}) do
    {:ok, payment} =
      attrs
      |> Enum.into(%{
        billrefnumber: "some billrefnumber",
        businessshortcode: "some businessshortcode",
        firstname: "some firstname",
        invoicenumber: "some invoicenumber",
        lastname: "some lastname",
        middlename: "some middlename",
        msisdn: "some msisdn",
        orgaccountbalance: "some orgaccountbalance",
        thirdpartytransid: "some thirdpartytransid",
        transactiontype: "some transactiontype",
        transamount: "some transamount",
        transid: "some transid",
        transtime: "some transtime"
      })
      |> Bestnowelixirmysql.Payments.create_payment()

    payment
  end
end
