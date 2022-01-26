defmodule Bestnowelixirmysql.Subscriptions.Subscription do
  use Ecto.Schema
  import Ecto.Changeset

  schema "subscriptions" do
    field :active, :boolean, default: false
    field :days, :integer
    field :uid, :integer

    timestamps()
  end

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, [:uid, :days, :active])
    |> validate_required([:uid, :days])
  end
end
