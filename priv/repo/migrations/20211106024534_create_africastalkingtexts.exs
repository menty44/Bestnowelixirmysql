defmodule Bestnowelixirmysql.Repo.Migrations.CreateAfricastalkingtexts do
  use Ecto.Migration

  def change do
    create table(:africastalkingtexts) do
      add :cost, :string
      add :messageId, :string
      add :messageParts, :integer
      add :number, :integer
      add :status, :string
      add :statusCode, :integer
      add :sentmessage, :text

      timestamps()
    end
  end
end
