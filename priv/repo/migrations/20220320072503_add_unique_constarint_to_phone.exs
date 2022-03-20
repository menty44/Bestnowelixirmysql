defmodule Bestnowelixirmysql.Repo.Migrations.AddUniqueConstarintToPhone do
  use Ecto.Migration

  def change do
    create unique_index(:mobileusers, [:phone])
  end
end
