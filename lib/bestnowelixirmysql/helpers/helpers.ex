defmodule Bestnowelixirmysql.Helpers do
  @doc """
  Convert an `Ecto.Schema` to a map that can be JSON encoded

  `Map.from_struct` only strips the `:__struct__` but leaves any unloaded
  relations which cannot be Poison encoded. This function will additionally
  recursively remove unloaded relations.
  """
  def map_from_schema(struct, opts \\ [])

  def map_from_schema(%{__struct__: schema} = struct, opts) do
    fields =
      Enum.map(
        schema.__schema__(:fields),
        &{&1, get_field_type(schema, :type, &1)}
      )

    assocs =
      Enum.map(
        schema.__schema__(:associations),
        &{&1, get_field_type(schema, :association, &1)}
      )

    map =
      (fields ++ assocs)
      |> Enum.reduce(%{}, fn {field, type}, a ->
        value = Map.get(struct, field)

        case process_field_value(type, value) do
          {:keep, v} ->
            Map.put(a, field, v)

          :drop ->
            a
        end
      end)

    if Keyword.get(opts, :string_keys) do
      stringify_map_keys(map)
    else
      map
    end
  end

  def map_from_schema(any, _), do: any

  defp get_field_type(schema, schema_type, field) do
    case schema.__schema__(schema_type, field) do
      {:embed, _} = type ->
        type

      %Ecto.Association.Has{cardinality: cardinality} ->
        {:assoc, cardinality}

      %Ecto.Association.BelongsTo{cardinality: :one} ->
        {:assoc, :one}

      %Ecto.Association.ManyToMany{} ->
        {:assoc, :many}

      type ->
        type
    end
  end

  defp process_field_value(_, nil), do: {:keep, nil}

  defp process_field_value(_, %Ecto.Association.NotLoaded{}), do: :drop

  defp process_field_value({:embed, %Ecto.Embedded{cardinality: :one}}, value) do
    {:keep, map_from_schema(value)}
  end

  defp process_field_value({:embed, %Ecto.Embedded{cardinality: :many}}, values) do
    {:keep, Enum.map(values, &map_from_schema/1)}
  end

  defp process_field_value({:assoc, :one}, value) do
    {:keep, map_from_schema(value)}
  end

  defp process_field_value({:assoc, :many}, values) do
    {:keep, Enum.map(values, &map_from_schema/1)}
  end

  defp process_field_value({:array, _t_ype}, values) when is_list(values) do
    {:keep, values}
  end

  defp process_field_value(_type, value), do: {:keep, value}

  @doc """
  Convert map atom keys to strings
  """
  def stringify_map_keys(nil), do: nil

  def stringify_map_keys(%{__struct__: _} = s), do: s

  def stringify_map_keys(map = %{}) do
    map
    |> Enum.map(fn {k, v} -> {to_string(k), stringify_map_keys(v)} end)
    |> Enum.into(%{})
  end

  # Walk the list and stringify the keys of
  # of any map members
  def stringify_map_keys([head | rest]) do
    [stringify_map_keys(head) | stringify_map_keys(rest)]
  end

  def stringify_map_keys(not_a_map) do
    not_a_map
  end
end
