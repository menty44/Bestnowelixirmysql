defmodule Bestnowelixirmysql.Smspackages do
  @moduledoc """
  The Smspackages context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Smspackages.Smspackage

  @doc """
  Returns the list of smspackages.

  ## Examples

      iex> list_smspackages()
      [%Smspackage{}, ...]

  """
  def list_smspackages do
    Repo.all(Smspackage)
  end

  @doc """
  Gets a single smspackage.

  Raises `Ecto.NoResultsError` if the Smspackage does not exist.

  ## Examples

      iex> get_smspackage!(123)
      %Smspackage{}

      iex> get_smspackage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_smspackage!(id), do: Repo.get!(Smspackage, id)

  @doc """
  Creates a smspackage.

  ## Examples

      iex> create_smspackage(%{field: value})
      {:ok, %Smspackage{}}

      iex> create_smspackage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_smspackage(attrs \\ %{}) do
    %Smspackage{}
    |> Smspackage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a smspackage.

  ## Examples

      iex> update_smspackage(smspackage, %{field: new_value})
      {:ok, %Smspackage{}}

      iex> update_smspackage(smspackage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_smspackage(%Smspackage{} = smspackage, attrs) do
    smspackage
    |> Smspackage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a smspackage.

  ## Examples

      iex> delete_smspackage(smspackage)
      {:ok, %Smspackage{}}

      iex> delete_smspackage(smspackage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_smspackage(%Smspackage{} = smspackage) do
    Repo.delete(smspackage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking smspackage changes.

  ## Examples

      iex> change_smspackage(smspackage)
      %Ecto.Changeset{data: %Smspackage{}}

  """
  def change_smspackage(%Smspackage{} = smspackage, attrs \\ %{}) do
    Smspackage.changeset(smspackage, attrs)
  end
end
