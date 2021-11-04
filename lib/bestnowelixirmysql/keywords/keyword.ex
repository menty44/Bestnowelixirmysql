defmodule Bestnowelixirmysql.Keywords.Keyword do
  use Ecto.Schema
  import Ecto.Changeset

  schema "keyword" do
    field :keyword, :string
    field :manager, :string
    field :owner, :string
    field :shortcode, :string

    timestamps()
  end

  @doc false
  def changeset(keyword, attrs) do
    keyword
    |> cast(attrs, [:shortcode, :keyword, :owner, :manager])
    |> validate_required([:shortcode, :keyword, :owner, :manager])
  end
end
