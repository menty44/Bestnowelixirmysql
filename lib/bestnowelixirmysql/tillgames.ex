defmodule Bestnowelixirmysql.Tillgames do
  @moduledoc """
  The Tillgames context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Tillgames.Tillgame

  @doc """
  Returns the list of tillgames.

  ## Examples

      iex> list_tillgames()
      [%Tillgame{}, ...]

  """
  def list_tillgames do
    Repo.all(Tillgame)
  end

  @doc """
  Gets a single tillgame.

  Raises `Ecto.NoResultsError` if the Tillgame does not exist.

  ## Examples

      iex> get_tillgame!(123)
      %Tillgame{}

      iex> get_tillgame!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tillgame!(id), do: Repo.get!(Tillgame, id)

  @doc """
  Creates a tillgame.

  ## Examples

      iex> create_tillgame(%{field: value})
      {:ok, %Tillgame{}}

      iex> create_tillgame(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tillgame(attrs \\ %{}) do
    %Tillgame{}
    |> Tillgame.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tillgame.

  ## Examples

      iex> update_tillgame(tillgame, %{field: new_value})
      {:ok, %Tillgame{}}

      iex> update_tillgame(tillgame, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tillgame(%Tillgame{} = tillgame, attrs) do
    tillgame
    |> Tillgame.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tillgame.

  ## Examples

      iex> delete_tillgame(tillgame)
      {:ok, %Tillgame{}}

      iex> delete_tillgame(tillgame)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tillgame(%Tillgame{} = tillgame) do
    Repo.delete(tillgame)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tillgame changes.

  ## Examples

      iex> change_tillgame(tillgame)
      %Ecto.Changeset{data: %Tillgame{}}

  """
  def change_tillgame(%Tillgame{} = tillgame, attrs \\ %{}) do
    Tillgame.changeset(tillgame, attrs)
  end

  def get_current_game_by_sms(amount) do
    from(g in Tillgame,
      where: g.amount == ^amount,
      where: g.commence >= ^convert_to_string(Timex.beginning_of_day(Timex.now())),
      where: g.commence <= ^convert_to_string(Timex.end_of_day(Timex.now())),
      order_by: [{:desc, g.commence}],
      limit: 1
    )
    |> Repo.all()
  end
end
