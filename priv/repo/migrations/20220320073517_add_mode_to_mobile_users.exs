defmodule Bestnowelixirmysql.Repo.Migrations.AddModeToMobileUsers do
  use Ecto.Migration

  def change do
    alter table(:mobileusers) do
      add :mode, :string
    end
  end
end
