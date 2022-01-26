defmodule Bestnowelixirmysql.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :uid, :integer
      add :days, :integer
      add :active, :boolean, default: false, null: false

      timestamps()
    end
  end
end
