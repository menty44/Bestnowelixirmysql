defmodule Bestnowelixirmysql.GamesTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Games

  describe "games" do
    alias Bestnowelixirmysql.Games.Game

    import Bestnowelixirmysql.GamesFixtures

    @invalid_attrs %{league: nil, match: nil, results: nil, time: nil, tip: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{
        league: "some league",
        match: "some match",
        results: "some results",
        time: "some time",
        tip: "some tip"
      }

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.league == "some league"
      assert game.match == "some match"
      assert game.results == "some results"
      assert game.time == "some time"
      assert game.tip == "some tip"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()

      update_attrs = %{
        league: "some updated league",
        match: "some updated match",
        results: "some updated results",
        time: "some updated time",
        tip: "some updated tip"
      }

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.league == "some updated league"
      assert game.match == "some updated match"
      assert game.results == "some updated results"
      assert game.time == "some updated time"
      assert game.tip == "some updated tip"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
