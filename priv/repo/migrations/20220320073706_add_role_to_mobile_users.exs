defmodule Bestnowelixirmysql.Repo.Migrations.AddRoleToMobileUsers do
  use Ecto.Migration

  def change do
    alter table :mobileusers do
      add :role, :string
    end
  end
end

