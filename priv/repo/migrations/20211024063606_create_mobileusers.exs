defmodule Bestnowelixirmysql.Repo.Migrations.CreateMobileusers do
  use Ecto.Migration

  def change do
    create table(:mobileusers) do
      add :password_hash, :string
      add :phone, :string
      add :firstname, :string
      add :lastname, :string

      timestamps()
    end
  end
end
