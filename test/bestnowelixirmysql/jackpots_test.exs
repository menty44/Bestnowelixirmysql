defmodule Bestnowelixirmysql.JackpotsTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Jackpots

  describe "jackpots" do
    alias Bestnowelixirmysql.Jackpots.Jackpot

    import Bestnowelixirmysql.JackpotsFixtures

    @invalid_attrs %{name: nil}

    test "list_jackpots/0 returns all jackpots" do
      jackpot = jackpot_fixture()
      assert Jackpots.list_jackpots() == [jackpot]
    end

    test "get_jackpot!/1 returns the jackpot with given id" do
      jackpot = jackpot_fixture()
      assert Jackpots.get_jackpot!(jackpot.id) == jackpot
    end

    test "create_jackpot/1 with valid data creates a jackpot" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Jackpot{} = jackpot} = Jackpots.create_jackpot(valid_attrs)
      assert jackpot.name == "some name"
    end

    test "create_jackpot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jackpots.create_jackpot(@invalid_attrs)
    end

    test "update_jackpot/2 with valid data updates the jackpot" do
      jackpot = jackpot_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Jackpot{} = jackpot} = Jackpots.update_jackpot(jackpot, update_attrs)
      assert jackpot.name == "some updated name"
    end

    test "update_jackpot/2 with invalid data returns error changeset" do
      jackpot = jackpot_fixture()
      assert {:error, %Ecto.Changeset{}} = Jackpots.update_jackpot(jackpot, @invalid_attrs)
      assert jackpot == Jackpots.get_jackpot!(jackpot.id)
    end

    test "delete_jackpot/1 deletes the jackpot" do
      jackpot = jackpot_fixture()
      assert {:ok, %Jackpot{}} = Jackpots.delete_jackpot(jackpot)
      assert_raise Ecto.NoResultsError, fn -> Jackpots.get_jackpot!(jackpot.id) end
    end

    test "change_jackpot/1 returns a jackpot changeset" do
      jackpot = jackpot_fixture()
      assert %Ecto.Changeset{} = Jackpots.change_jackpot(jackpot)
    end
  end
end
