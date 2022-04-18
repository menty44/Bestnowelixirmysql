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
    query = from(m in Mobileuser, order_by: [desc: m.id], limit: 200)
            |> Repo.all
#    Repo.all(Mobileuser)
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
    IO.inspect(attrs)

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

  def count_by_id!() do
    #    Repo.aggregate(from p in Mobileuser, :count, :id)
    #    Repo.one(from m in Mobileuser, select: count(m.id))  q
    Repo.one(from p in Mobileuser, select: fragment("count(*)"))
  end

  #  def account_type_query(queryable \\ __MODULE__, account_type) do
  #    account_type = account_type |> String.trim() |> String.downcase()
  #    from(u in queryable, where: u.account_type == ^account_type)
  #  end

  def update_user_payment(struct) do
#    Mobileuser.update_mobileuser(struct, %{"mode" => "activated"})
    struct
    |> Mobileuser.changeset(%{"mode" => "activated"})
    |> Repo.update()
  end

  def list_mobileusers_filter(to, from) do
    query = from(m in Mobileuser, order_by: [desc: m.id], limit: 200)

    query
    |> Repo.all

  end
end
