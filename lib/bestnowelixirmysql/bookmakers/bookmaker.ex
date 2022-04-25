defmodule Bestnowelixirmysql.Bookmakers.Bookmaker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookmakers" do
#    field :games, :string
    field :keyword, :string
    field :loadingdate, :string
    field :owner, :string
    field :shortcode, :string

    has_many :games, Bestnowelixirmysql.Games.Game

    timestamps()
  end

  @doc false
  def changeset(bookmaker, attrs) do
    bookmaker
    |> cast(attrs, [:shortcode, :loadingdate, :owner, :keyword])
    |> validate_required([:shortcode, :loadingdate, :owner, :keyword])
  end
end
