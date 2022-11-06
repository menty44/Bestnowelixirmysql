defmodule Bestnowelixirmysql.Smsgames.Smsgame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "smsgames" do
    field :amount, :string
    field :games, :string
    field :commence, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(smsgame, attrs) do
    smsgame
    |> cast(attrs, [:amount, :games, :commence])
    |> validate_required([:amount, :games])
  end

  defp process_date(att) do
    att
    |> IO.inspect
  end
end
