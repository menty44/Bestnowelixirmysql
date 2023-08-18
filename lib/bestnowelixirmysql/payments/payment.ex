defmodule Bestnowelixirmysql.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :billrefnumber, :string
    field :businessshortcode, :string
    field :firstname, :string
    field :invoicenumber, :string
    field :lastname, :string
    field :middlename, :string
    field :msisdn, :string
    field :orgaccountbalance, :string
    field :thirdpartytransid, :string
    field :transactiontype, :string
    field :transamount, :string
    field :transid, :string
    field :transtime, :string

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [
      :billrefnumber,
      :businessshortcode,
      :firstname,
      :middlename,
      :lastname,
      :invoicenumber,
      :msisdn,
      :orgaccountbalance,
      :thirdpartytransid,
      :transamount,
      :transid,
      :transtime,
      :transactiontype
    ])

    #    |> validate_required([:billrefnumber, :businessshortcode, :firstname, :middlename, :lastname, :invoicenumber, :msisdn, :orgaccountbalance, :thirdpartytransid, :transamount, :transid, :transtime, :transactiontype])
  end
end
