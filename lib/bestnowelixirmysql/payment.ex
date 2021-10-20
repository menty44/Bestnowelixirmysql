defmodule Bestnowelixirmysql.Payment do
  @moduledoc """
  The Payment context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Payment.Mobilepayments

  @doc """
  Returns the list of mobile_payments.

  ## Examples

      iex> list_mobile_payments()
      [%Mobilepayments{}, ...]

  """
  def list_mobile_payments do
    Repo.all(Mobilepayments)
  end

  @doc """
  Gets a single mobilepayments.

  Raises `Ecto.NoResultsError` if the Mobilepayments does not exist.

  ## Examples

      iex> get_mobilepayments!(123)
      %Mobilepayments{}

      iex> get_mobilepayments!(456)
      ** (Ecto.NoResultsError)

  """
  def get_mobilepayments!(id), do: Repo.get!(Mobilepayments, id)

  @doc """
  Creates a mobilepayments.

  ## Examples

      iex> create_mobilepayments(%{field: value})
      {:ok, %Mobilepayments{}}

      iex> create_mobilepayments(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_mobilepayments(attrs \\ %{}) do
    %Mobilepayments{}
    |> Mobilepayments.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a mobilepayments.

  ## Examples

      iex> update_mobilepayments(mobilepayments, %{field: new_value})
      {:ok, %Mobilepayments{}}

      iex> update_mobilepayments(mobilepayments, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_mobilepayments(%Mobilepayments{} = mobilepayments, attrs) do
    mobilepayments
    |> Mobilepayments.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a mobilepayments.

  ## Examples

      iex> delete_mobilepayments(mobilepayments)
      {:ok, %Mobilepayments{}}

      iex> delete_mobilepayments(mobilepayments)
      {:error, %Ecto.Changeset{}}

  """
  def delete_mobilepayments(%Mobilepayments{} = mobilepayments) do
    Repo.delete(mobilepayments)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking mobilepayments changes.

  ## Examples

      iex> change_mobilepayments(mobilepayments)
      %Ecto.Changeset{data: %Mobilepayments{}}

  """
  def change_mobilepayments(%Mobilepayments{} = mobilepayments, attrs \\ %{}) do
    Mobilepayments.changeset(mobilepayments, attrs)
  end
end
