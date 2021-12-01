defmodule Bestnowelixirmysql.PackagesTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Packages

  describe "packages" do
    alias Bestnowelixirmysql.Packages.Package

    import Bestnowelixirmysql.PackagesFixtures

    @invalid_attrs %{name: nil, price: nil}

    test "list_packages/0 returns all packages" do
      package = package_fixture()
      assert Packages.list_packages() == [package]
    end

    test "get_package!/1 returns the package with given id" do
      package = package_fixture()
      assert Packages.get_package!(package.id) == package
    end

    test "create_package/1 with valid data creates a package" do
      valid_attrs = %{name: "some name", price: 42}

      assert {:ok, %Package{} = package} = Packages.create_package(valid_attrs)
      assert package.name == "some name"
      assert package.price == 42
    end

    test "create_package/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Packages.create_package(@invalid_attrs)
    end

    test "update_package/2 with valid data updates the package" do
      package = package_fixture()
      update_attrs = %{name: "some updated name", price: 43}

      assert {:ok, %Package{} = package} = Packages.update_package(package, update_attrs)
      assert package.name == "some updated name"
      assert package.price == 43
    end

    test "update_package/2 with invalid data returns error changeset" do
      package = package_fixture()
      assert {:error, %Ecto.Changeset{}} = Packages.update_package(package, @invalid_attrs)
      assert package == Packages.get_package!(package.id)
    end

    test "delete_package/1 deletes the package" do
      package = package_fixture()
      assert {:ok, %Package{}} = Packages.delete_package(package)
      assert_raise Ecto.NoResultsError, fn -> Packages.get_package!(package.id) end
    end

    test "change_package/1 returns a package changeset" do
      package = package_fixture()
      assert %Ecto.Changeset{} = Packages.change_package(package)
    end
  end
end
