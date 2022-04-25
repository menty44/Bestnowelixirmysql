defmodule Bestnowelixirmysql.Repo.Migrations.CreateJackpots do
  use Ecto.Migration

  def change do
    create table(:jackpots) do
      add :name, :string

      timestamps()
    end
  end
end
