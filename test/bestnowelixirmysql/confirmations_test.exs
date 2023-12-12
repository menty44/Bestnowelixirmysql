defmodule Bestnowelixirmysql.ConfirmationsTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Confirmations

  describe "confirmations" do
    alias Bestnowelixirmysql.Confirmations.Confirmation

    import Bestnowelixirmysql.ConfirmationsFixtures

    @invalid_attrs %{amount: nil, mpesacode: nil, phone: nil}

    test "list_confirmations/0 returns all confirmations" do
      confirmation = confirmation_fixture()
      assert Confirmations.list_confirmations() == [confirmation]
    end

    test "get_confirmation!/1 returns the confirmation with given id" do
      confirmation = confirmation_fixture()
      assert Confirmations.get_confirmation!(confirmation.id) == confirmation
    end

    test "create_confirmation/1 with valid data creates a confirmation" do
      valid_attrs = %{amount: "some amount", mpesacode: "some mpesacode", phone: "some phone"}

      assert {:ok, %Confirmation{} = confirmation} = Confirmations.create_confirmation(valid_attrs)
      assert confirmation.amount == "some amount"
      assert confirmation.mpesacode == "some mpesacode"
      assert confirmation.phone == "some phone"
    end

    test "create_confirmation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Confirmations.create_confirmation(@invalid_attrs)
    end

    test "update_confirmation/2 with valid data updates the confirmation" do
      confirmation = confirmation_fixture()
      update_attrs = %{amount: "some updated amount", mpesacode: "some updated mpesacode", phone: "some updated phone"}

      assert {:ok, %Confirmation{} = confirmation} = Confirmations.update_confirmation(confirmation, update_attrs)
      assert confirmation.amount == "some updated amount"
      assert confirmation.mpesacode == "some updated mpesacode"
      assert confirmation.phone == "some updated phone"
    end

    test "update_confirmation/2 with invalid data returns error changeset" do
      confirmation = confirmation_fixture()
      assert {:error, %Ecto.Changeset{}} = Confirmations.update_confirmation(confirmation, @invalid_attrs)
      assert confirmation == Confirmations.get_confirmation!(confirmation.id)
    end

    test "delete_confirmation/1 deletes the confirmation" do
      confirmation = confirmation_fixture()
      assert {:ok, %Confirmation{}} = Confirmations.delete_confirmation(confirmation)
      assert_raise Ecto.NoResultsError, fn -> Confirmations.get_confirmation!(confirmation.id) end
    end

    test "change_confirmation/1 returns a confirmation changeset" do
      confirmation = confirmation_fixture()
      assert %Ecto.Changeset{} = Confirmations.change_confirmation(confirmation)
    end
  end
end
