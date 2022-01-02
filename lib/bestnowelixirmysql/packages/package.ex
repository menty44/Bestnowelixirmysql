defmodule Bestnowelixirmysql.Packages.Package do
  use Ecto.Schema
  import Ecto.Changeset

  schema "packages" do
    field :name, :string
    field :price, :integer
    field :duration, :integer

    timestamps()
  end

  @doc false
  def changeset(package, attrs) do
    package
    |> cast(attrs, [:name, :price, :duration])
    |> validate_required([:name, :price, :duration])
  end
end
