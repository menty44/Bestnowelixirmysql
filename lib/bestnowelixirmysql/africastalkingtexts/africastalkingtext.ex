defmodule Bestnowelixirmysql.Africastalkingtexts.Africastalkingtext do
  use Ecto.Schema
  import Ecto.Changeset

  schema "africastalkingtexts" do
    field :cost, :string
    field :messageId, :string
    field :messageParts, :integer
    field :number, :integer
    field :sentmessage, :string
    field :status, :string
    field :statusCode, :integer

    timestamps()
  end

  @doc false
  def changeset(africastalkingtext, attrs) do
    africastalkingtext
    |> cast(attrs, [:cost, :messageId, :messageParts, :number, :status, :statusCode, :sentmessage])
    |> validate_required([
      :cost,
      :messageId,
      :messageParts,
      :number,
      :status,
      :statusCode,
      :sentmessage
    ])
  end
end
