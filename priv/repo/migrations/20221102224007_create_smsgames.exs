defmodule Bestnowelixirmysql.Repo.Migrations.CreateSmsgames do
  use Ecto.Migration

  def change do
    create table(:smsgames) do
      add :amount, :string
      add :games, :string

      timestamps()
    end
  end
end
