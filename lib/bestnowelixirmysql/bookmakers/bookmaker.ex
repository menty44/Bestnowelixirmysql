defmodule Bestnowelixirmysql.Bookmakers.Bookmaker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookmakers" do
    field :games, :string
    field :keyword, :string
    field :loadingdate, :string
    field :owner, :string
    field :shortcode, :string

    timestamps()
  end

  @doc false
  def changeset(bookmaker, attrs) do
    bookmaker
    |> cast(attrs, [:shortcode, :games, :loadingdate, :owner, :keyword])
    |> validate_required([:shortcode, :games, :loadingdate, :owner, :keyword])
  end
end
