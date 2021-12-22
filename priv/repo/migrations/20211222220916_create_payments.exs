defmodule Bestnowelixirmysql.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :billrefnumber, :string
      add :businessshortcode, :string
      add :firstname, :string
      add :middlename, :string
      add :lastname, :string
      add :invoicenumber, :string
      add :msisdn, :string
      add :orgaccountbalance, :string
      add :thirdpartytransid, :string
      add :transamount, :string
      add :transid, :string
      add :transtime, :string
      add :transactiontype, :string

      timestamps()
    end
  end
end
