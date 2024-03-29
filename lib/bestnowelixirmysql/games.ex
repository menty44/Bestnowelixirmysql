defmodule Bestnowelixirmysql.Games do
  @moduledoc """
  The Games context.
  """

  import Ecto.Query, warn: true
  alias Bestnowelixirmysql.Repo

  alias Bestnowelixirmysql.Games.Game

  @doc """
  Returns the list of games.

  ## Examples

      iex> list_games()
      [%Game{}, ...]

  """
  def list_games do
    query =
      from(m in Game, order_by: [desc: m.id], limit: 200)
      |> Repo.all()
  end

  @doc """
  Gets a single game.

  Raises `Ecto.NoResultsError` if the Game does not exist.

  ## Examples

      iex> get_game!(123)
      %Game{}

      iex> get_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_game!(id), do: Repo.get!(Game, id)

  @doc """
  Creates a game.

  ## Examples

      iex> create_game(%{field: value})
      {:ok, %Game{}}

      iex> create_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a game.

  ## Examples

      iex> update_game(game, %{field: new_value})
      {:ok, %Game{}}

      iex> update_game(game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a game.

  ## Examples

      iex> delete_game(game)
      {:ok, %Game{}}

      iex> delete_game(game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking game changes.

  ## Examples

      iex> change_game(game)
      %Ecto.Changeset{data: %Game{}}

  """
  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  def games_archive_by_date!() do
    case Repo.all(archive_by_date_query) do
      nil ->
        {:error, :not_found}

      games ->
        {:ok, games}
    end
  end

  def games_active_by_date!() do
    case Repo.all(games_active_date_query) do
      nil ->
        {:error, :not_found}

      games ->
        {:ok, games}
    end
  end

  def games_active_date_query do
    d = convert_to_string(Timex.beginning_of_day(Timex.now()))
    from g in Game, where: g.inserted_at > ^d, order_by: [desc: g.id], limit: 200
  end

  def archive_by_date_query do
    d = convert_to_string(Timex.beginning_of_day(Timex.now()))

    from g in Game,
      where: g.results == g.tip and g.inserted_at < ^d,
      order_by: [desc: g.id],
      limit: 200
  end

  def filter_by_date_query(from, to) do
    new_from = from <> " 00:00:00.000000Z"
    new_to = to <> " 00:00:00.000000Z"

    mq =
      from g in Game,
        where: g.inserted_at >= ^new_from and g.inserted_at <= ^new_to,
        order_by: [desc: g.id],
        limit: 200

    mq
    |> Repo.all()
  end

  def convert_to_string(param) do
    DateTime.to_string(param)
  end
end
