defmodule Bestnowelixirmysql.Mobileaccounts do
  @moduledoc """
  The Mobileaccounts context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Mobileaccounts.Mobileuser

  @doc """
  Returns the list of mobileusers.

  ## Examples

      iex> list_mobileusers()
      [%Mobileuser{}, ...]

  """
  def list_mobileusers do
    Repo.all(Mobileuser)
  end

  @doc """
  Gets a single mobileuser.

  Raises `Ecto.NoResultsError` if the Mobileuser does not exist.

  ## Examples

      iex> get_mobileuser!(123)
      %Mobileuser{}

      iex> get_mobileuser!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mobileuser!(id), do: Repo.get!(Mobileuser, id)

  @doc """
  Creates a mobileuser.

  ## Examples

      iex> create_mobileuser(%{field: value})
      {:ok, %Mobileuser{}}

      iex> create_mobileuser(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mobileuser(attrs \\ %{}) do
    %Mobileuser{}
    |> Mobileuser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mobileuser.

  ## Examples

      iex> update_mobileuser(mobileuser, %{field: new_value})
      {:ok, %Mobileuser{}}

      iex> update_mobileuser(mobileuser, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mobileuser(%Mobileuser{} = mobileuser, attrs) do
    mobileuser
    |> Mobileuser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mobileuser.

  ## Examples

      iex> delete_mobileuser(mobileuser)
      {:ok, %Mobileuser{}}

      iex> delete_mobileuser(mobileuser)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mobileuser(%Mobileuser{} = mobileuser) do
    Repo.delete(mobileuser)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mobileuser changes.

  ## Examples

      iex> change_mobileuser(mobileuser)
      %Ecto.Changeset{data: %Mobileuser{}}

  """
  def change_mobileuser(%Mobileuser{} = mobileuser, attrs \\ %{}) do
    Mobileuser.changeset(mobileuser, attrs)
  end

  def get_by_phone!(phone) do
    case Repo.get_by(Mobileuser, phone: phone) do
      nil ->
        {:error, :not_found}
      mobileuser ->
        {:ok, mobileuser}
    end
  end
end
