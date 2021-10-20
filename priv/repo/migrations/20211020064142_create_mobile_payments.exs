defmodule Bestnowelixirmysql.Repo.Migrations.CreateMobilePayments do
  use Ecto.Migration

  def change do
    create table(:mobile_payments) do
      add :transLoID, :integer
      add :TransID, :string
      add :TransTime, :string
      add :TransAmount, :string
      add :BusinessShortCode, :string
      add :OrgAccountBalance, :string
      add :MSISDN, :string
      add :FirstName, :string
      add :MiddleName, :string
      add :LastName, :string

      timestamps()
    end
  end
end
