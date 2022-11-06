defmodule Bestnowelixirmysql.Repo.Migrations.AddCommenceDateColumn do
  use Ecto.Migration

  def change do
#    alter table elixir
    alter table(:smsgames) do
      add :commence, :naive_datetime
    end
  end
end
