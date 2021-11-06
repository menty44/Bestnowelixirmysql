defmodule Bestnowelixirmysql.Payment.Paybill do
  use Ecto.Schema
  import Ecto.Changeset

  schema "paybill" do
    field :BillRefNumber, :string
    field :BusinessShortCode, :string
    field :FirstName, :string
    field :InvoiceNumber, :string
    field :LastName, :string
    field :MSISDN, :string
    field :MiddleName, :string
    field :OrgAccountBalance, :string
    field :ThirdPartyTransID, :string
    field :TransAmount, :string
    field :TransDate, :string
    field :TransID, :string
    field :TransTime, :string
    field :TransactionType, :string
    field :transLoID, :integer, primary: true
  end

  @doc false
  def changeset(paybill, attrs) do
    paybill
    |> cast(attrs, [
      :TransID,
      :TransTime,
      :TransAmount,
      :BusinessShortCode,
      :OrgAccountBalance,
      :MSISDN,
      :FirstName,
      :MiddleName,
      :LastName,
      :TransactionType,
      :TransDate,
      :InvoiceNumber,
      :BillRefNumber,
      :OrgAccountBalance,
      :ThirdPartyTransID
    ])
    |> validate_required([
      :TransID,
      :TransTime,
      :TransAmount,
      :BusinessShortCode,
      :OrgAccountBalance,
      :MSISDN,
      :FirstName,
      :MiddleName,
      :LastName,
      :TransactionType,
      :TransDate,
      :InvoiceNumber,
      :BillRefNumber,
      :OrgAccountBalance,
      :ThirdPartyTransID
    ])
  end
end
