defmodule Bestnowelixirmysql.Repo.Migrations.CreateTillgames do
  use Ecto.Migration

  def change do
    create table(:tillgames) do
      add :amount, :string
      add :games, :string
      add :commence, :naive_datetime

      timestamps()
    end
  end
end
