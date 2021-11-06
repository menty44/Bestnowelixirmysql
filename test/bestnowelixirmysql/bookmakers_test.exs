defmodule Bestnowelixirmysql.BookmakersTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Bookmakers

  describe "bookmakers" do
    alias Bestnowelixirmysql.Bookmakers.Bookmaker

    import Bestnowelixirmysql.BookmakersFixtures

    @invalid_attrs %{games: nil, keyword: nil, loadingdate: nil, owner: nil, shortcode: nil}

    test "list_bookmakers/0 returns all bookmakers" do
      bookmaker = bookmaker_fixture()
      assert Bookmakers.list_bookmakers() == [bookmaker]
    end

    test "get_bookmaker!/1 returns the bookmaker with given id" do
      bookmaker = bookmaker_fixture()
      assert Bookmakers.get_bookmaker!(bookmaker.id) == bookmaker
    end

    test "create_bookmaker/1 with valid data creates a bookmaker" do
      valid_attrs = %{
        games: "some games",
        keyword: "some keyword",
        loadingdate: "some loadingdate",
        owner: "some owner",
        shortcode: "some shortcode"
      }

      assert {:ok, %Bookmaker{} = bookmaker} = Bookmakers.create_bookmaker(valid_attrs)
      assert bookmaker.games == "some games"
      assert bookmaker.keyword == "some keyword"
      assert bookmaker.loadingdate == "some loadingdate"
      assert bookmaker.owner == "some owner"
      assert bookmaker.shortcode == "some shortcode"
    end

    test "create_bookmaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookmakers.create_bookmaker(@invalid_attrs)
    end

    test "update_bookmaker/2 with valid data updates the bookmaker" do
      bookmaker = bookmaker_fixture()

      update_attrs = %{
        games: "some updated games",
        keyword: "some updated keyword",
        loadingdate: "some updated loadingdate",
        owner: "some updated owner",
        shortcode: "some updated shortcode"
      }

      assert {:ok, %Bookmaker{} = bookmaker} =
               Bookmakers.update_bookmaker(bookmaker, update_attrs)

      assert bookmaker.games == "some updated games"
      assert bookmaker.keyword == "some updated keyword"
      assert bookmaker.loadingdate == "some updated loadingdate"
      assert bookmaker.owner == "some updated owner"
      assert bookmaker.shortcode == "some updated shortcode"
    end

    test "update_bookmaker/2 with invalid data returns error changeset" do
      bookmaker = bookmaker_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookmakers.update_bookmaker(bookmaker, @invalid_attrs)
      assert bookmaker == Bookmakers.get_bookmaker!(bookmaker.id)
    end

    test "delete_bookmaker/1 deletes the bookmaker" do
      bookmaker = bookmaker_fixture()
      assert {:ok, %Bookmaker{}} = Bookmakers.delete_bookmaker(bookmaker)
      assert_raise Ecto.NoResultsError, fn -> Bookmakers.get_bookmaker!(bookmaker.id) end
    end

    test "change_bookmaker/1 returns a bookmaker changeset" do
      bookmaker = bookmaker_fixture()
      assert %Ecto.Changeset{} = Bookmakers.change_bookmaker(bookmaker)
    end
  end
end
