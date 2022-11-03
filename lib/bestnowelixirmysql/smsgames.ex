defmodule Bestnowelixirmysql.Smsgames do
  @moduledoc """
  The Smsgames context.
  """
#  use Timex

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Smsgames.Smsgame
  alias Timex
  @doc """
  Returns the list of smsgames.

  ## Examples

      iex> list_smsgames()
      [%Smsgame{}, ...]

  """
  def list_smsgames do
    Repo.all(Smsgame)
  end

  @doc """
  Gets a single smsgame.

  Raises `Ecto.NoResultsError` if the Smsgame does not exist.

  ## Examples

      iex> get_smsgame!(123)
      %Smsgame{}

      iex> get_smsgame!(456)
      ** (Ecto.NoResultsError)

  """
  def get_smsgame!(id), do: Repo.get!(Smsgame, id)

  @doc """
  Creates a smsgame.

  ## Examples

      iex> create_smsgame(%{field: value})
      {:ok, %Smsgame{}}

      iex> create_smsgame(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_smsgame(attrs \\ %{}) do
    %Smsgame{}
    |> Smsgame.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a smsgame.

  ## Examples

      iex> update_smsgame(smsgame, %{field: new_value})
      {:ok, %Smsgame{}}

      iex> update_smsgame(smsgame, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_smsgame(%Smsgame{} = smsgame, attrs) do
    smsgame
    |> Smsgame.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a smsgame.

  ## Examples

      iex> delete_smsgame(smsgame)
      {:ok, %Smsgame{}}

      iex> delete_smsgame(smsgame)
      {:error, %Ecto.Changeset{}}

  """
  def delete_smsgame(%Smsgame{} = smsgame) do
    Repo.delete(smsgame)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking smsgame changes.

  ## Examples

      iex> change_smsgame(smsgame)
      %Ecto.Changeset{data: %Smsgame{}}

  """
  def change_smsgame(%Smsgame{} = smsgame, attrs \\ %{}) do
    Smsgame.changeset(smsgame, attrs)
  end

  def get_current_game_by_sms(amount) do
    (from g in Smsgame,
    where: g.amount ==^ amount,
    where: g.inserted_at > ^ convert_to_string(Timex.beginning_of_day(Timex.now()))
    )
    |> Repo.one
  end

  def convert_to_string(param) do
    DateTime.to_string(param)
  end

end
