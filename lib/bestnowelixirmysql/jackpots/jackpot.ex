defmodule Bestnowelixirmysql.Jackpots.Jackpot do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jackpots" do
    field :name, :string

    has_many :jackpotgames, Bestnowelixirmysql.Jackgames.Jackpotgame

    timestamps()
  end

  @doc false
  def changeset(jackpot, attrs) do
    jackpot
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
