defmodule Bestnowelixirmysql.Tillgames.Tillgame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tillgames" do
    field :amount, :string
    field :games, :string
    field :commence, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(tillgame, attrs) do
    tillgame
    |> cast(attrs, [:amount, :games])
    |> validate_required([:amount, :games])
  end
end
