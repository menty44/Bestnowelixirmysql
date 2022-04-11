defmodule Bestnowelixirmysql.Keywords do
  @moduledoc """
  The Keywords context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Keywords.Keyword

  @doc """
  Returns the list of keyword.

  ## Examples

      iex> list_keyword()
      [%Keyword{}, ...]

  """
  def list_keyword do
    query = from(m in Keyword, order_by: [desc: m.id], limit: 100)
            |> Repo.all
#    Repo.all(Keyword)
  end

  @doc """
  Gets a single keyword.

  Raises `Ecto.NoResultsError` if the Keyword does not exist.

  ## Examples

      iex> get_keyword!(123)
      %Keyword{}

      iex> get_keyword!(456)
      ** (Ecto.NoResultsError)

  """
  def get_keyword!(id) do
    #    Repo.get!(Keyword, id)
    case Repo.get(Keyword, id) do
      nil -> {:error, :not_found}
      keyword -> {:ok, keyword}
    end
  end

  @doc """
  Creates a keyword.

  ## Examples

      iex> create_keyword(%{field: value})
      {:ok, %Keyword{}}

      iex> create_keyword(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_keyword(attrs \\ %{}) do
    %Keyword{}
    |> Keyword.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a keyword.

  ## Examples

      iex> update_keyword(keyword, %{field: new_value})
      {:ok, %Keyword{}}

      iex> update_keyword(keyword, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_keyword(%Keyword{} = keyword, attrs) do
    keyword
    |> Keyword.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a keyword.

  ## Examples

      iex> delete_keyword(keyword)
      {:ok, %Keyword{}}

      iex> delete_keyword(keyword)
      {:error, %Ecto.Changeset{}}

  """
  def delete_keyword!(%Keyword{} = keyword) do
    Repo.delete(keyword)
    #    with {:ok, keyword} <- Repo.delete(keyword) do
    #        IO.inspect :ok
    #      else
    #      nil -> {:error, :not_found, "supplied id not found"}
    #      _ -> {:error, :not_found, "supplied id not found"}
    #    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking keyword changes.

  ## Examples

      iex> change_keyword(keyword)
      %Ecto.Changeset{data: %Keyword{}}

  """
  def change_keyword(%Keyword{} = keyword, attrs \\ %{}) do
    Keyword.changeset(keyword, attrs)
  end

  def count_by_id!() do
    #    Repo.aggregate(from p in Mobileuser, :count, :id)
    #    Repo.one(from m in Mobileuser, select: count(m.id))
    Repo.one(from p in Keyword, select: fragment("count(*)"))
  end
end
