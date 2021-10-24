defmodule Bestnowelixirmysql.Mobileaccounts.Mobileuser do
  use Ecto.Schema
  import Ecto.Changeset
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "mobileusers" do
    field :firstname, :string
    field :lastname, :string
    field :password_hash, :string
    field :phone, :string

    # Virtual fields:
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(mobileuser, attrs) do
    mobileuser
    |> cast(attrs, [:password, :phone, :firstname, :lastname])
    |> validate_required([:password, :phone, :firstname, :lastname])
    |> unique_constraint(:phone)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
      ->
        put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
