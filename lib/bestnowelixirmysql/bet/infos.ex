defmodule Bestnowelixirmysql.Bet.Infos do
  use Ecto.Schema
  import Ecto.Changeset

  schema "info" do
    #    field :id, :integer, virtual: true
    field :info_id, :integer, primary_key: true
    field :date_added, :date
    field :keyword, :string
    field :messages, :string
    field :shortcode, :integer
  end

  @doc false
  def changeset(infos, attrs) do
    infos
    |> cast(attrs, [:keyword, :shortcode, :messages, :date_added])
    |> validate_required([:keyword, :shortcode, :messages, :date_added])
  end
end
