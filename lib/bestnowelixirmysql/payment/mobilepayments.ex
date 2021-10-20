defmodule Bestnowelixirmysql.Payment.Mobilepayments do
  use Ecto.Schema
  import Ecto.Changeset

  schema "mobile_payments" do
    field :BusinessShortCode, :string
    field :FirstName, :string
    field :LastName, :string
    field :MSISDN, :string
    field :MiddleName, :string
    field :OrgAccountBalance, :string
    field :TransAmount, :string
    field :TransID, :string
    field :TransTime, :string
    field :transLoID, :integer, primary: true
  end

  @doc false
  def changeset(mobilepayments, attrs) do
    mobilepayments
    |> cast(attrs, [:TransID, :TransTime, :TransAmount, :BusinessShortCode, :OrgAccountBalance, :MSISDN, :FirstName, :MiddleName, :LastName])
    |> validate_required([:TransID, :TransTime, :TransAmount, :BusinessShortCode, :OrgAccountBalance, :MSISDN, :FirstName, :MiddleName, :LastName])
  end
end
