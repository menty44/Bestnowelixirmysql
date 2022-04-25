defmodule Bestnowelixirmysql.Jackgames.Jackpotgame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jackpotgames" do
    field :league, :string
    field :match, :string
    field :results, :string
    field :time, :string
    field :tip, :string

    belongs_to :jackpot, Bestnowelixirmysql.Jackpots.Jackpot

    timestamps()
  end

  @doc false
  def changeset(jackpotgame, attrs) do
    jackpotgame
    |> cast(attrs, [:time, :league, :match, :tip, :results])
    |> validate_required([:time, :league, :match, :tip, :results])
  end
end
