defmodule Bestnowelixirmysql.Repo.Migrations.CreateJackpotgames do
  use Ecto.Migration

  def change do
    create table(:jackpotgames) do
      add :time, :string
      add :league, :string
      add :match, :string
      add :tip, :string
      add :results, :string
      add :jackpot_id, references(:jackpots)

      timestamps()
    end
  end
end
