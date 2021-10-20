defmodule Bestnowelixirmysql.Bet do
  @moduledoc """
  The Bet context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Bet.Infos

  @doc """
  Returns the list of info.

  ## Examples

      iex> list_info()
      [%Infos{}, ...]

  """
  def list_info do
    Repo.all(Infos)
  end

  @doc """
  Gets a single infos.

  Raises `Ecto.NoResultsError` if the Infos does not exist.

  ## Examples

      iex> get_infos!(123)
      %Infos{}

      iex> get_infos!(456)
      ** (Ecto.NoResultsError)

  """
  def get_infos!(info_id), do: Repo.get!(Infos, info_id)

  @doc """
  Creates a infos.

  ## Examples

      iex> create_infos(%{field: value})
      {:ok, %Infos{}}

      iex> create_infos(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_infos(attrs \\ %{}) do
    %Infos{}
    |> Infos.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a infos.

  ## Examples

      iex> update_infos(infos, %{field: new_value})
      {:ok, %Infos{}}

      iex> update_infos(infos, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_infos(%Infos{} = infos, attrs) do
    infos
    |> Infos.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a infos.

  ## Examples

      iex> delete_infos(infos)
      {:ok, %Infos{}}

      iex> delete_infos(infos)
      {:error, %Ecto.Changeset{}}

  """
  def delete_infos(%Infos{} = infos) do
    Repo.delete(infos)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking infos changes.

  ## Examples

      iex> change_infos(infos)
      %Ecto.Changeset{data: %Infos{}}

  """
  def change_infos(%Infos{} = infos, attrs \\ %{}) do
    Infos.changeset(infos, attrs)
  end
end
