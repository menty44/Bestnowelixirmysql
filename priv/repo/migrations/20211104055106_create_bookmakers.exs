defmodule Bestnowelixirmysql.Repo.Migrations.CreateBookmakers do
  use Ecto.Migration

  def change do
    create table(:bookmakers) do
      add :shortcode, :string
      add :games, :text
      add :loadingdate, :string
      add :owner, :string
      add :keyword, :string

      timestamps()
    end
  end
end
