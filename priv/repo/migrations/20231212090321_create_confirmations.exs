defmodule Bestnowelixirmysql.Repo.Migrations.CreateConfirmations do
  use Ecto.Migration

  def change do
    create table(:confirmations) do
      add :phone, :string
      add :amount, :string
      add :mpesacode, :string

      timestamps()
    end
  end
end
