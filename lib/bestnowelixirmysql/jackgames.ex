defmodule Bestnowelixirmysql.Jackgames do
  @moduledoc """
  The Jackgames context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Jackgames.Jackpotgame

  @doc """
  Returns the list of jackpotgames.

  ## Examples

      iex> list_jackpotgames()
      [%Jackpotgame{}, ...]

  """
  def list_jackpotgames do
    Jackpotgame
    |> order_by([desc: :id])
    |> limit(100)
    |> Repo.all()
  end

  @doc """
  Gets a single jackpotgame.

  Raises `Ecto.NoResultsError` if the Jackpotgame does not exist.

  ## Examples

      iex> get_jackpotgame!(123)
      %Jackpotgame{}

      iex> get_jackpotgame!(456)
      ** (Ecto.NoResultsError)

  """
  def get_jackpotgame!(id), do: Repo.get!(Jackpotgame, id)

  @doc """
  Creates a jackpotgame.

  ## Examples

      iex> create_jackpotgame(%{field: value})
      {:ok, %Jackpotgame{}}

      iex> create_jackpotgame(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_jackpotgame(attrs \\ %{}) do
    %Jackpotgame{}
    |> Jackpotgame.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a jackpotgame.

  ## Examples

      iex> update_jackpotgame(jackpotgame, %{field: new_value})
      {:ok, %Jackpotgame{}}

      iex> update_jackpotgame(jackpotgame, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_jackpotgame(%Jackpotgame{} = jackpotgame, attrs) do
    jackpotgame
    |> Jackpotgame.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a jackpotgame.

  ## Examples

      iex> delete_jackpotgame(jackpotgame)
      {:ok, %Jackpotgame{}}

      iex> delete_jackpotgame(jackpotgame)
      {:error, %Ecto.Changeset{}}

  """
  def delete_jackpotgame(%Jackpotgame{} = jackpotgame) do
    Repo.delete(jackpotgame)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking jackpotgame changes.

  ## Examples

      iex> change_jackpotgame(jackpotgame)
      %Ecto.Changeset{data: %Jackpotgame{}}

  """
  def change_jackpotgame(%Jackpotgame{} = jackpotgame, attrs \\ %{}) do
    Jackpotgame.changeset(jackpotgame, attrs)
  end
end
