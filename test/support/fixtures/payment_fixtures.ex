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

  @doc """
  Generate a mobilepayments.
  """
  def mobilepayments_fixture(attrs \\ %{}) do
    {:ok, mobilepayments} =
      attrs
      |> Enum.into(%{
        BillRefNumber: "some BillRefNumber",
        BusinessShortCode: "some BusinessShortCode",
        FirstName: "some FirstName",
        InvoiceNumber: "some InvoiceNumber",
        LastName: "some LastName",
        MSISDN: "some MSISDN",
        MiddleName: "some MiddleName",
        OrgAccountBalance: "some OrgAccountBalance",
        ThirdPartyTransID: "some ThirdPartyTransID",
        TransAmount: "some TransAmount",
        TransDate: "some TransDate",
        TransID: "some TransID",
        TransTime: "some TransTime",
        TransactionType: "some TransactionType",
        transLoID: 42
      })
      |> Bestnowelixirmysql.Payment.create_mobilepayments()

    mobilepayments
  end

  @doc """
  Generate a till.
  """
  def till_fixture(attrs \\ %{}) do
    {:ok, till} =
      attrs
      |> Enum.into(%{
        BillRefNumber: "some BillRefNumber",
        BusinessShortCode: "some BusinessShortCode",
        FirstName: "some FirstName",
        InvoiceNumber: "some InvoiceNumber",
        LastName: "some LastName",
        MSISDN: "some MSISDN",
        MiddleName: "some MiddleName",
        OrgAccountBalance: "some OrgAccountBalance",
        ThirdPartyTransID: "some ThirdPartyTransID",
        TransAmount: "some TransAmount",
        TransDate: "some TransDate",
        TransID: "some TransID",
        TransTime: "some TransTime",
        TransactionType: "some TransactionType",
        transLoID: 42
      })
      |> Bestnowelixirmysql.Payment.create_till()

    till
  end

  @doc """
  Generate a paybill.
  """
  def paybill_fixture(attrs \\ %{}) do
    {:ok, paybill} =
      attrs
      |> Enum.into(%{
        BillRefNumber: "some BillRefNumber",
        BusinessShortCode: "some BusinessShortCode",
        FirstName: "some FirstName",
        InvoiceNumber: "some InvoiceNumber",
        LastName: "some LastName",
        MSISDN: "some MSISDN",
        MiddleName: "some MiddleName",
        OrgAccountBalance: "some OrgAccountBalance",
        ThirdPartyTransID: "some ThirdPartyTransID",
        TransAmount: "some TransAmount",
        TransDate: "some TransDate",
        TransID: "some TransID",
        TransTime: "some TransTime",
        TransactionType: "some TransactionType",
        transLoID: 42
      })
      |> Bestnowelixirmysql.Payment.create_paybill()

    paybill
  end
end
