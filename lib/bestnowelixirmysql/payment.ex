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
    query = from(m in Mobilepayments, order_by: [desc: m.id], limit: 200)
            |> Repo.all
#    Repo.all(Mobilepayments)
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
  def get_mobilepayments!(transLoID), do: Repo.get!(Mobilepayments, transLoID)

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

  alias Bestnowelixirmysql.Payment.Mobilepayments

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

  alias Bestnowelixirmysql.Payment.Till

  @doc """
  Returns the list of tills.

  ## Examples

      iex> list_tills()
      [%Till{}, ...]

  """
  def list_tills do
    query = from(m in Till, order_by: [desc: m.id], limit: 200)
            |> Repo.all
#    Repo.all(Till)
  end

  @doc """
  Gets a single till.

  Raises `Ecto.NoResultsError` if the Till does not exist.

  ## Examples

      iex> get_till!(123)
      %Till{}

      iex> get_till!(456)
      ** (Ecto.NoResultsError)

  """
  def get_till!(transLoID), do: Repo.get!(Till, transLoID)

  @doc """
  Creates a till.

  ## Examples

      iex> create_till(%{field: value})
      {:ok, %Till{}}

      iex> create_till(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_till(attrs \\ %{}) do
    %Till{}
    |> Till.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a till.

  ## Examples

      iex> update_till(till, %{field: new_value})
      {:ok, %Till{}}

      iex> update_till(till, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_till(%Till{} = till, attrs) do
    till
    |> Till.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a till.

  ## Examples

      iex> delete_till(till)
      {:ok, %Till{}}

      iex> delete_till(till)
      {:error, %Ecto.Changeset{}}

  """
  def delete_till(%Till{} = till) do
    Repo.delete(till)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking till changes.

  ## Examples

      iex> change_till(till)
      %Ecto.Changeset{data: %Till{}}

  """
  def change_till(%Till{} = till, attrs \\ %{}) do
    Till.changeset(till, attrs)
  end

  alias Bestnowelixirmysql.Payment.Paybill

  @doc """
  Returns the list of paybill.

  ## Examples

      iex> list_paybill()
      [%Paybill{}, ...]

  """
  def list_paybill do
    query = from(m in Paybill, order_by: [desc: m.id], limit: 200)
            |> Repo.all
#    Repo.all(Paybill)
  end

  @doc """
  Gets a single paybill.

  Raises `Ecto.NoResultsError` if the Paybill does not exist.

  ## Examples

      iex> get_paybill!(123)
      %Paybill{}

      iex> get_paybill!(456)
      ** (Ecto.NoResultsError)

  """
  def get_paybill!(transLoID), do: Repo.get!(Paybill, transLoID)

  @doc """
  Creates a paybill.

  ## Examples

      iex> create_paybill(%{field: value})
      {:ok, %Paybill{}}

      iex> create_paybill(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_paybill(attrs \\ %{}) do
    %Paybill{}
    |> Paybill.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a paybill.

  ## Examples

      iex> update_paybill(paybill, %{field: new_value})
      {:ok, %Paybill{}}

      iex> update_paybill(paybill, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_paybill(%Paybill{} = paybill, attrs) do
    paybill
    |> Paybill.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a paybill.

  ## Examples

      iex> delete_paybill(paybill)
      {:ok, %Paybill{}}

      iex> delete_paybill(paybill)
      {:error, %Ecto.Changeset{}}

  """
  def delete_paybill(%Paybill{} = paybill) do
    Repo.delete(paybill)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking paybill changes.

  ## Examples

      iex> change_paybill(paybill)
      %Ecto.Changeset{data: %Paybill{}}

  """
  def change_paybill(%Paybill{} = paybill, attrs \\ %{}) do
    Paybill.changeset(paybill, attrs)
  end

  def paybill_by_phone!(ohone) do
    case Repo.all(
           from u in Paybill,
             where: u."MSISDN" == ^ohone,
             order_by: [desc: :transLoID],
             limit: 10
         ) do
      nil ->
        {:error, :not_found}

      paybill ->
        {:ok, paybill}
    end
  end

  def till_by_phone!(ohone) do
    case Repo.all(
           from u in Till,
             where: u."MSISDN" == ^ohone,
             order_by: [desc: :transLoID],
             limit: 10
         ) do
      nil ->
        {:error, :not_found}

      till ->
        {:ok, till}
    end
  end

  def archive_by_date!(phone) do
    case Repo.all(Bestnowelixirmysql.Payment, msisdn: phone) do
      nil ->
        {:error, :not_found}
      payment ->
        {:ok, payment}
    end
  end
end
