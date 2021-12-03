defmodule Bestnowelixirmysql.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :time, :string
      add :league, :string
      add :match, :string
      add :tip, :string
      add :results, :string
      add :bookmaker_id, references(:bookmakers)

      timestamps()
    end
  end
end
