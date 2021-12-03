#defmodule Bestnowelixirmysql.Repo.Migrations.CreateGames do
#  use Ecto.Migration
#
#  def up do
#    alter table(:games) do
#       modify(:bookmaker_id, references(:bookmakers, on_delete: :delete_all))
#    end
#  end
#end
