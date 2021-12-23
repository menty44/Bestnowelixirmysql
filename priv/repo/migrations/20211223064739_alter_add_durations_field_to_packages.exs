defmodule Bestnowelixirmysql.Repo.Migrations.AlterAddDurationsFieldToPackages do
  use Ecto.Migration

  def change do
    alter table(:packages) do
      add :duration, :integer
    end
  end
end
