defmodule Bestnowelixirmysql.Repo.Migrations.CreateSmspackages do
  use Ecto.Migration

  def change do
    create table(:smspackages) do
      add :uid, :string
      add :amount, :string

      timestamps()
    end
  end
end
