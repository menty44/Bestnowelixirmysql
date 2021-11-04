defmodule Bestnowelixirmysql.Repo.Migrations.CreateKeyword do
  use Ecto.Migration

  def change do
    create table(:keyword) do
      add :shortcode, :string
      add :keyword, :string
      add :owner, :string
      add :manager, :string

      timestamps()
    end
  end
end
