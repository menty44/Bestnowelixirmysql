defmodule Bestnowelixirmysql.RepoHelpers do
  @moduledoc """
  Convenience macros so Repo backed schemas don't have to re-implement some common accesser functions
  """

  import Ecto.Query, only: [from: 1, from: 2]

  defmacro __using__(opts) do
    quote do
      import Ecto.Query

      @repo Keyword.fetch!(unquote(opts), :repo)

      def get!(queryable \\ __MODULE__, id), do: @repo.get!(queryable, id)
      def get(queryable \\ __MODULE__, id), do: @repo.get(queryable, id)
      def get_by(queryable \\ __MODULE__, fields), do: @repo.get_by(queryable, fields)
      def get_by!(queryable \\ __MODULE__, fields), do: @repo.get_by!(queryable, fields)

      def one!(queryable \\ __MODULE__), do: @repo.one!(queryable)
      def one(queryable \\ __MODULE__), do: @repo.one(queryable)

      def one(queryable, opts) do
        Automzero.RepoHelpers.query_from_opts(queryable, opts)
        |> @repo.one()
      end

      def count(queryable \\ __MODULE__) do
        from(q in queryable, select: count("*"))
        |> @repo.one
      end

      def all(queryable \\ __MODULE__, opts \\ []) do
        query = Automzero.RepoHelpers.query_from_opts(queryable, opts)

        from(q in query, order_by: q.id)
        |> @repo.all(opts)
      end

      def newest() do
        from(m in newest_query(), limit: 1)
        |> @repo.one
      end

      def newest_query(queryable \\ __MODULE__) do
        from(m in queryable, order_by: [desc: :id])
      end

      def archived_query(queryable \\ __MODULE__, archived) do
        case archived do
          "archived" -> from(q in queryable, where: not is_nil(q.archived_at))
          "active" -> from(q in queryable, where: is_nil(q.archived_at))
          _ -> queryable
        end
      end

      def delete(id) when is_binary(id) or is_integer(id) do
        # use delete_all so we dont to load the record first
        from(m in __MODULE__, where: m.id == ^id)
        |> @repo.delete_all()
      end

      def delete_all(queryable \\ __MODULE__) do
        @repo.delete_all(queryable)
      end

      def paginate(queryable \\ __MODULE__, params) do
        @repo.paginate(queryable, params)
      end

      def to_date_query(queryable \\ __MODULE__, datetime, col \\ :inserted_at) do
        queryable
        |> where([q], field(q, ^col) <= ^datetime)
      end

      def from_date_query(queryable \\ __MODULE__, datetime, col \\ :inserted_at) do
        queryable
        |> where([q], field(q, ^col) >= ^datetime)
      end

      def sum(queryable \\ __MODULE__, field) do
        from(q in queryable, select: sum(field(q, ^field)))
        |> @repo.one()
      end

      def preload_fields(queryable, field_or_fields) do
        @repo.preload(queryable, field_or_fields)
      end

      defoverridable delete: 1, get_by!: 2, get_by: 2, get_by!: 1, get_by: 1
    end
  end

  @doc """
  Add selects, offsets, limits and order_by clauses from opts

  ## Options

    - :select - Columns to select
    - :offset - Number of rows to offset
    - :limit - Number of rows to return
    - :order_by - Columns to sort by
  """
  @spec query_from_opts(Ecto.Queryable.t(), Keyword.t()) :: Ecto.Query.t()
  def query_from_opts(queryable, opts) do
    {columns, opts} = Keyword.pop(opts, :select, [])
    {offset, opts} = Keyword.pop(opts, :offset)
    {limit, opts} = Keyword.pop(opts, :limit)
    {order_by, _opts} = Keyword.pop(opts, :order_by)

    select_for_opts(queryable, columns)
    |> order_by_for_opts(order_by)
    |> offset_for_opts(offset)
    |> limit_for_opts(limit)
  end

  # explicit call to from for when a bare schem is passed in without options as this would just return the module
  defp select_for_opts(queryable, []), do: from(queryable)

  defp select_for_opts(queryable, columns) when is_list(columns) do
    from(queryable, select: ^columns)
  end

  defp order_by_for_opts(queryable, nil), do: queryable

  defp order_by_for_opts(queryable, order_by) do
    from(queryable, order_by: ^order_by)
  end

  defp offset_for_opts(queryable, nil), do: queryable

  defp offset_for_opts(queryable, offset) when offset >= 0 do
    from(queryable, offset: ^offset)
  end

  defp limit_for_opts(queryable, nil), do: queryable

  defp limit_for_opts(queryable, limit) when limit >= 0 do
    from(queryable, limit: ^limit)
  end
end
