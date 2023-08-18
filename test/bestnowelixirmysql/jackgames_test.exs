defmodule Bestnowelixirmysql.JackgamesTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Jackgames

  describe "jackpotgames" do
    alias Bestnowelixirmysql.Jackgames.Jackpotgame

    import Bestnowelixirmysql.JackgamesFixtures

    @invalid_attrs %{league: nil, match: nil, results: nil, time: nil, tip: nil}

    test "list_jackpotgames/0 returns all jackpotgames" do
      jackpotgame = jackpotgame_fixture()
      assert Jackgames.list_jackpotgames() == [jackpotgame]
    end

    test "get_jackpotgame!/1 returns the jackpotgame with given id" do
      jackpotgame = jackpotgame_fixture()
      assert Jackgames.get_jackpotgame!(jackpotgame.id) == jackpotgame
    end

    test "create_jackpotgame/1 with valid data creates a jackpotgame" do
      valid_attrs = %{
        league: "some league",
        match: "some match",
        results: "some results",
        time: "some time",
        tip: "some tip"
      }

      assert {:ok, %Jackpotgame{} = jackpotgame} = Jackgames.create_jackpotgame(valid_attrs)
      assert jackpotgame.league == "some league"
      assert jackpotgame.match == "some match"
      assert jackpotgame.results == "some results"
      assert jackpotgame.time == "some time"
      assert jackpotgame.tip == "some tip"
    end

    test "create_jackpotgame/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Jackgames.create_jackpotgame(@invalid_attrs)
    end

    test "update_jackpotgame/2 with valid data updates the jackpotgame" do
      jackpotgame = jackpotgame_fixture()

      update_attrs = %{
        league: "some updated league",
        match: "some updated match",
        results: "some updated results",
        time: "some updated time",
        tip: "some updated tip"
      }

      assert {:ok, %Jackpotgame{} = jackpotgame} =
               Jackgames.update_jackpotgame(jackpotgame, update_attrs)

      assert jackpotgame.league == "some updated league"
      assert jackpotgame.match == "some updated match"
      assert jackpotgame.results == "some updated results"
      assert jackpotgame.time == "some updated time"
      assert jackpotgame.tip == "some updated tip"
    end

    test "update_jackpotgame/2 with invalid data returns error changeset" do
      jackpotgame = jackpotgame_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Jackgames.update_jackpotgame(jackpotgame, @invalid_attrs)

      assert jackpotgame == Jackgames.get_jackpotgame!(jackpotgame.id)
    end

    test "delete_jackpotgame/1 deletes the jackpotgame" do
      jackpotgame = jackpotgame_fixture()
      assert {:ok, %Jackpotgame{}} = Jackgames.delete_jackpotgame(jackpotgame)
      assert_raise Ecto.NoResultsError, fn -> Jackgames.get_jackpotgame!(jackpotgame.id) end
    end

    test "change_jackpotgame/1 returns a jackpotgame changeset" do
      jackpotgame = jackpotgame_fixture()
      assert %Ecto.Changeset{} = Jackgames.change_jackpotgame(jackpotgame)
    end
  end
end
