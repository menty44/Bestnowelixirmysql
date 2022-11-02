defmodule Bestnowelixirmysql.SmsgamesTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Smsgames

  describe "smsgames" do
    alias Bestnowelixirmysql.Smsgames.Smsgame

    import Bestnowelixirmysql.SmsgamesFixtures

    @invalid_attrs %{amount: nil, games: nil}

    test "list_smsgames/0 returns all smsgames" do
      smsgame = smsgame_fixture()
      assert Smsgames.list_smsgames() == [smsgame]
    end

    test "get_smsgame!/1 returns the smsgame with given id" do
      smsgame = smsgame_fixture()
      assert Smsgames.get_smsgame!(smsgame.id) == smsgame
    end

    test "create_smsgame/1 with valid data creates a smsgame" do
      valid_attrs = %{amount: "some amount", games: "some games"}

      assert {:ok, %Smsgame{} = smsgame} = Smsgames.create_smsgame(valid_attrs)
      assert smsgame.amount == "some amount"
      assert smsgame.games == "some games"
    end

    test "create_smsgame/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Smsgames.create_smsgame(@invalid_attrs)
    end

    test "update_smsgame/2 with valid data updates the smsgame" do
      smsgame = smsgame_fixture()
      update_attrs = %{amount: "some updated amount", games: "some updated games"}

      assert {:ok, %Smsgame{} = smsgame} = Smsgames.update_smsgame(smsgame, update_attrs)
      assert smsgame.amount == "some updated amount"
      assert smsgame.games == "some updated games"
    end

    test "update_smsgame/2 with invalid data returns error changeset" do
      smsgame = smsgame_fixture()
      assert {:error, %Ecto.Changeset{}} = Smsgames.update_smsgame(smsgame, @invalid_attrs)
      assert smsgame == Smsgames.get_smsgame!(smsgame.id)
    end

    test "delete_smsgame/1 deletes the smsgame" do
      smsgame = smsgame_fixture()
      assert {:ok, %Smsgame{}} = Smsgames.delete_smsgame(smsgame)
      assert_raise Ecto.NoResultsError, fn -> Smsgames.get_smsgame!(smsgame.id) end
    end

    test "change_smsgame/1 returns a smsgame changeset" do
      smsgame = smsgame_fixture()
      assert %Ecto.Changeset{} = Smsgames.change_smsgame(smsgame)
    end
  end
end
