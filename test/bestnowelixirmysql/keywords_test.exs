defmodule Bestnowelixirmysql.KeywordsTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Keywords

  describe "keyword" do
    alias Bestnowelixirmysql.Keywords.Keyword

    import Bestnowelixirmysql.KeywordsFixtures

    @invalid_attrs %{keyword: nil, manager: nil, owner: nil, shortcode: nil}

    test "list_keyword/0 returns all keyword" do
      keyword = keyword_fixture()
      assert Keywords.list_keyword() == [keyword]
    end

    test "get_keyword!/1 returns the keyword with given id" do
      keyword = keyword_fixture()
      assert Keywords.get_keyword!(keyword.id) == keyword
    end

    test "create_keyword/1 with valid data creates a keyword" do
      valid_attrs = %{
        keyword: "some keyword",
        manager: "some manager",
        owner: "some owner",
        shortcode: "some shortcode"
      }

      assert {:ok, %Keyword{} = keyword} = Keywords.create_keyword(valid_attrs)
      assert keyword.keyword == "some keyword"
      assert keyword.manager == "some manager"
      assert keyword.owner == "some owner"
      assert keyword.shortcode == "some shortcode"
    end

    test "create_keyword/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Keywords.create_keyword(@invalid_attrs)
    end

    test "update_keyword/2 with valid data updates the keyword" do
      keyword = keyword_fixture()

      update_attrs = %{
        keyword: "some updated keyword",
        manager: "some updated manager",
        owner: "some updated owner",
        shortcode: "some updated shortcode"
      }

      assert {:ok, %Keyword{} = keyword} = Keywords.update_keyword(keyword, update_attrs)
      assert keyword.keyword == "some updated keyword"
      assert keyword.manager == "some updated manager"
      assert keyword.owner == "some updated owner"
      assert keyword.shortcode == "some updated shortcode"
    end

    test "update_keyword/2 with invalid data returns error changeset" do
      keyword = keyword_fixture()
      assert {:error, %Ecto.Changeset{}} = Keywords.update_keyword(keyword, @invalid_attrs)
      assert keyword == Keywords.get_keyword!(keyword.id)
    end

    test "delete_keyword/1 deletes the keyword" do
      keyword = keyword_fixture()
      assert {:ok, %Keyword{}} = Keywords.delete_keyword(keyword)
      assert_raise Ecto.NoResultsError, fn -> Keywords.get_keyword!(keyword.id) end
    end

    test "change_keyword/1 returns a keyword changeset" do
      keyword = keyword_fixture()
      assert %Ecto.Changeset{} = Keywords.change_keyword(keyword)
    end
  end
end
