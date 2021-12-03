defmodule Bestnowelixirmysql.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :league, :string
    field :match, :string
    field :results, :string
    field :time, :string
    field :tip, :string
    belongs_to :bookmaker, Bestnowelixirmysql.Bookmakers.Bookmaker

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:time, :league, :match, :tip, :results])
    |> validate_required([:time, :league, :match, :tip, :results])
  end
end
