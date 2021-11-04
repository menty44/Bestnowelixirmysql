defmodule Bestnowelixirmysql.Bookmakers do
  @moduledoc """
  The Bookmakers context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Bookmakers.Bookmaker

  @doc """
  Returns the list of bookmakers.

  ## Examples

      iex> list_bookmakers()
      [%Bookmaker{}, ...]

  """
  def list_bookmakers do
    Repo.all(Bookmaker)
  end

  @doc """
  Gets a single bookmaker.

  Raises `Ecto.NoResultsError` if the Bookmaker does not exist.

  ## Examples

      iex> get_bookmaker!(123)
      %Bookmaker{}

      iex> get_bookmaker!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bookmaker!(id), do: Repo.get!(Bookmaker, id)

  @doc """
  Creates a bookmaker.

  ## Examples

      iex> create_bookmaker(%{field: value})
      {:ok, %Bookmaker{}}

      iex> create_bookmaker(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bookmaker(attrs \\ %{}) do
    %Bookmaker{}
    |> Bookmaker.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bookmaker.

  ## Examples

      iex> update_bookmaker(bookmaker, %{field: new_value})
      {:ok, %Bookmaker{}}

      iex> update_bookmaker(bookmaker, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bookmaker(%Bookmaker{} = bookmaker, attrs) do
    bookmaker
    |> Bookmaker.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bookmaker.

  ## Examples

      iex> delete_bookmaker(bookmaker)
      {:ok, %Bookmaker{}}

      iex> delete_bookmaker(bookmaker)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bookmaker(%Bookmaker{} = bookmaker) do
    Repo.delete(bookmaker)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bookmaker changes.

  ## Examples

      iex> change_bookmaker(bookmaker)
      %Ecto.Changeset{data: %Bookmaker{}}

  """
  def change_bookmaker(%Bookmaker{} = bookmaker, attrs \\ %{}) do
    Bookmaker.changeset(bookmaker, attrs)
  end
end
