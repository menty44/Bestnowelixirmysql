defmodule Bestnowelixirmysql.PackagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bestnowelixirmysql.Packages` context.
  """

  @doc """
  Generate a package.
  """
  def package_fixture(attrs \\ %{}) do
    {:ok, package} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: 42
      })
      |> Bestnowelixirmysql.Packages.create_package()

    package
  end
end
