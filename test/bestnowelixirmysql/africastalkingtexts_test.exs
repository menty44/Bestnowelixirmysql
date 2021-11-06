defmodule Bestnowelixirmysql.AfricastalkingtextsTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Africastalkingtexts

  describe "africastalkingtexts" do
    alias Bestnowelixirmysql.Africastalkingtexts.Africastalkingtext

    import Bestnowelixirmysql.AfricastalkingtextsFixtures

    @invalid_attrs %{
      cost: nil,
      messageId: nil,
      messageParts: nil,
      number: nil,
      sentmessage: nil,
      status: nil,
      statusCode: nil
    }

    test "list_africastalkingtexts/0 returns all africastalkingtexts" do
      africastalkingtext = africastalkingtext_fixture()
      assert Africastalkingtexts.list_africastalkingtexts() == [africastalkingtext]
    end

    test "get_africastalkingtext!/1 returns the africastalkingtext with given id" do
      africastalkingtext = africastalkingtext_fixture()

      assert Africastalkingtexts.get_africastalkingtext!(africastalkingtext.id) ==
               africastalkingtext
    end

    test "create_africastalkingtext/1 with valid data creates a africastalkingtext" do
      valid_attrs = %{
        cost: "some cost",
        messageId: "some messageId",
        messageParts: 42,
        number: 42,
        sentmessage: "some sentmessage",
        status: "some status",
        statusCode: 42
      }

      assert {:ok, %Africastalkingtext{} = africastalkingtext} =
               Africastalkingtexts.create_africastalkingtext(valid_attrs)

      assert africastalkingtext.cost == "some cost"
      assert africastalkingtext.messageId == "some messageId"
      assert africastalkingtext.messageParts == 42
      assert africastalkingtext.number == 42
      assert africastalkingtext.sentmessage == "some sentmessage"
      assert africastalkingtext.status == "some status"
      assert africastalkingtext.statusCode == 42
    end

    test "create_africastalkingtext/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Africastalkingtexts.create_africastalkingtext(@invalid_attrs)
    end

    test "update_africastalkingtext/2 with valid data updates the africastalkingtext" do
      africastalkingtext = africastalkingtext_fixture()

      update_attrs = %{
        cost: "some updated cost",
        messageId: "some updated messageId",
        messageParts: 43,
        number: 43,
        sentmessage: "some updated sentmessage",
        status: "some updated status",
        statusCode: 43
      }

      assert {:ok, %Africastalkingtext{} = africastalkingtext} =
               Africastalkingtexts.update_africastalkingtext(africastalkingtext, update_attrs)

      assert africastalkingtext.cost == "some updated cost"
      assert africastalkingtext.messageId == "some updated messageId"
      assert africastalkingtext.messageParts == 43
      assert africastalkingtext.number == 43
      assert africastalkingtext.sentmessage == "some updated sentmessage"
      assert africastalkingtext.status == "some updated status"
      assert africastalkingtext.statusCode == 43
    end

    test "update_africastalkingtext/2 with invalid data returns error changeset" do
      africastalkingtext = africastalkingtext_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Africastalkingtexts.update_africastalkingtext(africastalkingtext, @invalid_attrs)

      assert africastalkingtext ==
               Africastalkingtexts.get_africastalkingtext!(africastalkingtext.id)
    end

    test "delete_africastalkingtext/1 deletes the africastalkingtext" do
      africastalkingtext = africastalkingtext_fixture()

      assert {:ok, %Africastalkingtext{}} =
               Africastalkingtexts.delete_africastalkingtext(africastalkingtext)

      assert_raise Ecto.NoResultsError, fn ->
        Africastalkingtexts.get_africastalkingtext!(africastalkingtext.id)
      end
    end

    test "change_africastalkingtext/1 returns a africastalkingtext changeset" do
      africastalkingtext = africastalkingtext_fixture()
      assert %Ecto.Changeset{} = Africastalkingtexts.change_africastalkingtext(africastalkingtext)
    end
  end
end
