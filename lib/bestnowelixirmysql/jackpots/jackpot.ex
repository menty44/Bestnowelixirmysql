defmodule Bestnowelixirmysql.Jackpots.Jackpot do
  use Ecto.Schema
  import Ecto.Changeset

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  schema "jackpots" do
    field :name, :string

    has_many :jackpotgames, Bestnowelixirmysql.Jackgames.Jackpotgame

    timestamps()
  end

  @doc false
  def changeset(jackpot, attrs) do
    jackpot
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def list_jackpots_descend do
    __MODULE__
    |> order_by(desc: :id)
    |> limit(8)
    |> Repo.all()
  end

  def get_by_id_preload!(id, __MODULE__ \\ Bestnowelixirmysql.Jackpots.Jackpot) do
    from(
      j in Bestnowelixirmysql.Jackpots.Jackpot,
      select: j,
      where: j.id == ^id
    )
    |> preload(:jackpotgames)
    |> Repo.all()
    |> IO.inspect
  end
end
