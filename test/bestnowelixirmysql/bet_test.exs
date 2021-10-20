defmodule Bestnowelixirmysql.BetTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Bet

  describe "info" do
    alias Bestnowelixirmysql.Bet.Infos

    import Bestnowelixirmysql.BetFixtures

    @invalid_attrs %{date_added: nil, keyword: nil, messages: nil, shortcode: nil}

    test "list_info/0 returns all info" do
      infos = infos_fixture()
      assert Bet.list_info() == [infos]
    end

    test "get_infos!/1 returns the infos with given id" do
      infos = infos_fixture()
      assert Bet.get_infos!(infos.info_id) == infos
    end

    test "create_infos/1 with valid data creates a infos" do
      valid_attrs = %{date_added: ~D[2021-10-19], keyword: "some keyword", messages: "some messages", shortcode: 42}

      assert {:ok, %Infos{} = infos} = Bet.create_infos(valid_attrs)
      assert infos.date_added == ~D[2021-10-19]
      assert infos.keyword == "some keyword"
      assert infos.messages == "some messages"
      assert infos.shortcode == 42
    end

    test "create_infos/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bet.create_infos(@invalid_attrs)
    end

    test "update_infos/2 with valid data updates the infos" do
      infos = infos_fixture()
      update_attrs = %{date_added: ~D[2021-10-20], keyword: "some updated keyword", messages: "some updated messages", shortcode: 43}

      assert {:ok, %Infos{} = infos} = Bet.update_infos(infos, update_attrs)
      assert infos.date_added == ~D[2021-10-20]
      assert infos.keyword == "some updated keyword"
      assert infos.messages == "some updated messages"
      assert infos.shortcode == 43
    end

    test "update_infos/2 with invalid data returns error changeset" do
      infos = infos_fixture()
      assert {:error, %Ecto.Changeset{}} = Bet.update_infos(infos, @invalid_attrs)
      assert infos == Bet.get_infos!(infos.info_id)
    end

    test "delete_infos/1 deletes the infos" do
      infos = infos_fixture()
      assert {:ok, %Infos{}} = Bet.delete_infos(infos)
      assert_raise Ecto.NoResultsError, fn -> Bet.get_infos!(infos.info_id) end
    end

    test "change_infos/1 returns a infos changeset" do
      infos = infos_fixture()
      assert %Ecto.Changeset{} = Bet.change_infos(infos)
    end
  end
end
