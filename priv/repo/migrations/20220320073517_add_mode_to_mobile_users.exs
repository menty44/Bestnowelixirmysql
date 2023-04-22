defmodule Bestnowelixirmysql.Repo.Migrations.AddModeToMobileUsers do
  use Ecto.Migration

  def change do
    alter table(:mobileusers) do
      add_if_not_exists :mode, :string
    end
  end
end
