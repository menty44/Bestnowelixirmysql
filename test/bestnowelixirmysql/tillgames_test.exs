defmodule Bestnowelixirmysql.TillgamesTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Tillgames

  describe "tillgames" do
    alias Bestnowelixirmysql.Tillgames.Tillgame

    import Bestnowelixirmysql.TillgamesFixtures

    @invalid_attrs %{amount: nil, games: nil}

    test "list_tillgames/0 returns all tillgames" do
      tillgame = tillgame_fixture()
      assert Tillgames.list_tillgames() == [tillgame]
    end

    test "get_tillgame!/1 returns the tillgame with given id" do
      tillgame = tillgame_fixture()
      assert Tillgames.get_tillgame!(tillgame.id) == tillgame
    end

    test "create_tillgame/1 with valid data creates a tillgame" do
      valid_attrs = %{amount: "some amount", games: "some games"}

      assert {:ok, %Tillgame{} = tillgame} = Tillgames.create_tillgame(valid_attrs)
      assert tillgame.amount == "some amount"
      assert tillgame.games == "some games"
    end

    test "create_tillgame/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tillgames.create_tillgame(@invalid_attrs)
    end

    test "update_tillgame/2 with valid data updates the tillgame" do
      tillgame = tillgame_fixture()
      update_attrs = %{amount: "some updated amount", games: "some updated games"}

      assert {:ok, %Tillgame{} = tillgame} = Tillgames.update_tillgame(tillgame, update_attrs)
      assert tillgame.amount == "some updated amount"
      assert tillgame.games == "some updated games"
    end

    test "update_tillgame/2 with invalid data returns error changeset" do
      tillgame = tillgame_fixture()
      assert {:error, %Ecto.Changeset{}} = Tillgames.update_tillgame(tillgame, @invalid_attrs)
      assert tillgame == Tillgames.get_tillgame!(tillgame.id)
    end

    test "delete_tillgame/1 deletes the tillgame" do
      tillgame = tillgame_fixture()
      assert {:ok, %Tillgame{}} = Tillgames.delete_tillgame(tillgame)
      assert_raise Ecto.NoResultsError, fn -> Tillgames.get_tillgame!(tillgame.id) end
    end

    test "change_tillgame/1 returns a tillgame changeset" do
      tillgame = tillgame_fixture()
      assert %Ecto.Changeset{} = Tillgames.change_tillgame(tillgame)
    end
  end
end
