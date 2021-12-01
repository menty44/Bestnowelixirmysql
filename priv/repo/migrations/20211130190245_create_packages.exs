defmodule Bestnowelixirmysql.Repo.Migrations.CreatePackages do
  use Ecto.Migration

  def change do
    create table(:packages) do
      add :name, :string
      add :price, :integer

      timestamps()
    end
  end
end
