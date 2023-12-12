defmodule Bestnowelixirmysql.Confirmations.Confirmation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "confirmations" do
    field :amount, :string
    field :mpesacode, :string
    field :phone, :string

    timestamps()
  end

  @doc false
  def changeset(confirmation, attrs) do
    confirmation
    |> cast(attrs, [:phone, :amount, :mpesacode])
    |> validate_required([:phone, :amount, :mpesacode])
  end
end
