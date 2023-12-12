  defmodule Bestnowelixirmysql.Confirmations do
  @moduledoc """
  The Confirmations context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Confirmations.Confirmation

  @doc """
  Returns the list of confirmations.

  ## Examples

      iex> list_confirmations()
      [%Confirmation{}, ...]

  """
  def list_confirmations do
    Repo.all(Confirmation)
  end

  @doc """
  Gets a single confirmation.

  Raises `Ecto.NoResultsError` if the Confirmation does not exist.

  ## Examples

      iex> get_confirmation!(123)
      %Confirmation{}

      iex> get_confirmation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_confirmation!(id), do: Repo.get!(Confirmation, id)

  @doc """
  Creates a confirmation.

  ## Examples

      iex> create_confirmation(%{field: value})
      {:ok, %Confirmation{}}

      iex> create_confirmation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_confirmation(attrs \\ %{}) do
    %Confirmation{}
    |> Confirmation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a confirmation.

  ## Examples

      iex> update_confirmation(confirmation, %{field: new_value})
      {:ok, %Confirmation{}}

      iex> update_confirmation(confirmation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_confirmation(%Confirmation{} = confirmation, attrs) do
    confirmation
    |> Confirmation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a confirmation.

  ## Examples

      iex> delete_confirmation(confirmation)
      {:ok, %Confirmation{}}

      iex> delete_confirmation(confirmation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_confirmation(%Confirmation{} = confirmation) do
    Repo.delete(confirmation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking confirmation changes.

  ## Examples

      iex> change_confirmation(confirmation)
      %Ecto.Changeset{data: %Confirmation{}}

  """
  def change_confirmation(%Confirmation{} = confirmation, attrs \\ %{}) do
    Confirmation.changeset(confirmation, attrs)
  end
end
