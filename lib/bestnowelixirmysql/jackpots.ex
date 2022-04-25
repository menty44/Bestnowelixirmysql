defmodule Bestnowelixirmysql.Jackpots do
  @moduledoc """
  The Jackpots context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Jackpots.Jackpot

  @doc """
  Returns the list of jackpots.

  ## Examples

      iex> list_jackpots()
      [%Jackpot{}, ...]

  """
  def list_jackpots do
    Repo.all(Jackpot)
  end

  @doc """
  Gets a single jackpot.

  Raises `Ecto.NoResultsError` if the Jackpot does not exist.

  ## Examples

      iex> get_jackpot!(123)
      %Jackpot{}

      iex> get_jackpot!(456)
      ** (Ecto.NoResultsError)

  """
  def get_jackpot!(id), do: Repo.get!(Jackpot, id)

  @doc """
  Creates a jackpot.

  ## Examples

      iex> create_jackpot(%{field: value})
      {:ok, %Jackpot{}}

      iex> create_jackpot(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_jackpot(attrs \\ %{}) do
    %Jackpot{}
    |> Jackpot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a jackpot.

  ## Examples

      iex> update_jackpot(jackpot, %{field: new_value})
      {:ok, %Jackpot{}}

      iex> update_jackpot(jackpot, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_jackpot(%Jackpot{} = jackpot, attrs) do
    jackpot
    |> Jackpot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a jackpot.

  ## Examples

      iex> delete_jackpot(jackpot)
      {:ok, %Jackpot{}}

      iex> delete_jackpot(jackpot)
      {:error, %Ecto.Changeset{}}

  """
  def delete_jackpot(%Jackpot{} = jackpot) do
    Repo.delete(jackpot)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking jackpot changes.

  ## Examples

      iex> change_jackpot(jackpot)
      %Ecto.Changeset{data: %Jackpot{}}

  """
  def change_jackpot(%Jackpot{} = jackpot, attrs \\ %{}) do
    Jackpot.changeset(jackpot, attrs)
  end
end
