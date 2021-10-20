defmodule Bestnowelixirmysql.Payment.Till do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tills" do
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
  def changeset(till, attrs) do
    till
    |> cast(attrs, [:TransID, :TransTime, :TransAmount, :BusinessShortCode, :OrgAccountBalance, :MSISDN, :FirstName, :MiddleName, :LastName, :TransactionType, :TransDate, :InvoiceNumber, :BillRefNumber, :OrgAccountBalance, :ThirdPartyTransID])
    |> validate_required([:TransID, :TransTime, :TransAmount, :BusinessShortCode, :OrgAccountBalance, :MSISDN, :FirstName, :MiddleName, :LastName, :TransactionType, :TransDate, :InvoiceNumber, :BillRefNumber, :OrgAccountBalance, :ThirdPartyTransID])
  end
end
