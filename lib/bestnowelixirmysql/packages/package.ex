defmodule Bestnowelixirmysql.Packages.Package do
  use Ecto.Schema
  import Ecto.Changeset

  schema "packages" do
    field :name, :string
    field :price, :integer

    timestamps()
  end

  @doc false
  def changeset(package, attrs) do
    package
    |> cast(attrs, [:name, :price])
    |> validate_required([:name, :price])
  end
end
