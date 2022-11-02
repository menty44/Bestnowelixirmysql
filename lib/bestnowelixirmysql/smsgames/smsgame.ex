defmodule Bestnowelixirmysql.Smsgames.Smsgame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "smsgames" do
    field :amount, :string
    field :games, :string

    timestamps()
  end

  @doc false
  def changeset(smsgame, attrs) do
    smsgame
    |> cast(attrs, [:amount, :games])
    |> validate_required([:amount, :games])
  end
end
