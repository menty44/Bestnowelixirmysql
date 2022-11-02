defmodule Bestnowelixirmysql.Smspackages.Smspackage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "smspackages" do
    field :amount, :string
    field :uid, :string

    timestamps()
  end

  @doc false
  def changeset(smspackage, attrs) do
    smspackage
    |> cast(attrs, [:uid, :amount])
    |> validate_required([:uid, :amount])
  end
end
