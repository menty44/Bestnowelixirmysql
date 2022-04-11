defmodule Bestnowelixirmysql.Africastalkingtexts do
  @moduledoc """
  The Africastalkingtexts context.
  """

  import Ecto.Query, warn: false
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Africastalkingtexts.Africastalkingtext

  @doc """
  Returns the list of africastalkingtexts.

  ## Examples

      iex> list_africastalkingtexts()
      [%Africastalkingtext{}, ...]

  """
  def list_africastalkingtexts do
    query = from(m in Africastalkingtext, order_by: [desc: m.id], limit: 200)
            |> Repo.all
#    Repo.all(Africastalkingtext)
  end

  @doc """
  Gets a single africastalkingtext.

  Raises `Ecto.NoResultsError` if the Africastalkingtext does not exist.

  ## Examples

      iex> get_africastalkingtext!(123)
      %Africastalkingtext{}

      iex> get_africastalkingtext!(456)
      ** (Ecto.NoResultsError)

  """
  def get_africastalkingtext!(id), do: Repo.get!(Africastalkingtext, id)

  @doc """
  Creates a africastalkingtext.

  ## Examples

      iex> create_africastalkingtext(%{field: value})
      {:ok, %Africastalkingtext{}}

      iex> create_africastalkingtext(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_africastalkingtext(attrs \\ %{}) do
    %Africastalkingtext{}
    |> Africastalkingtext.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a africastalkingtext.

  ## Examples

      iex> update_africastalkingtext(africastalkingtext, %{field: new_value})
      {:ok, %Africastalkingtext{}}

      iex> update_africastalkingtext(africastalkingtext, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_africastalkingtext(%Africastalkingtext{} = africastalkingtext, attrs) do
    africastalkingtext
    |> Africastalkingtext.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a africastalkingtext.

  ## Examples

      iex> delete_africastalkingtext(africastalkingtext)
      {:ok, %Africastalkingtext{}}

      iex> delete_africastalkingtext(africastalkingtext)
      {:error, %Ecto.Changeset{}}

  """
  def delete_africastalkingtext(%Africastalkingtext{} = africastalkingtext) do
    Repo.delete(africastalkingtext)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking africastalkingtext changes.

  ## Examples

      iex> change_africastalkingtext(africastalkingtext)
      %Ecto.Changeset{data: %Africastalkingtext{}}

  """
  def change_africastalkingtext(%Africastalkingtext{} = africastalkingtext, attrs \\ %{}) do
    Africastalkingtext.changeset(africastalkingtext, attrs)
  end

  def count_by_id!() do
    #    Repo.aggregate(from p in Mobileuser, :count, :id)
    #    Repo.one(from m in Mobileuser, select: count(m.id))  q
    Repo.one(from p in Africastalkingtext, select: fragment("count(*)"))
  end
end
