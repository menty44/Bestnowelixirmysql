defmodule Bestnowelixirmysql.SmspackagesTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Smspackages

  describe "smspackages" do
    alias Bestnowelixirmysql.Smspackages.Smspackage

    import Bestnowelixirmysql.SmspackagesFixtures

    @invalid_attrs %{amount: nil, uid: nil}

    test "list_smspackages/0 returns all smspackages" do
      smspackage = smspackage_fixture()
      assert Smspackages.list_smspackages() == [smspackage]
    end

    test "get_smspackage!/1 returns the smspackage with given id" do
      smspackage = smspackage_fixture()
      assert Smspackages.get_smspackage!(smspackage.id) == smspackage
    end

    test "create_smspackage/1 with valid data creates a smspackage" do
      valid_attrs = %{amount: "some amount", uid: "some uid"}

      assert {:ok, %Smspackage{} = smspackage} = Smspackages.create_smspackage(valid_attrs)
      assert smspackage.amount == "some amount"
      assert smspackage.uid == "some uid"
    end

    test "create_smspackage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Smspackages.create_smspackage(@invalid_attrs)
    end

    test "update_smspackage/2 with valid data updates the smspackage" do
      smspackage = smspackage_fixture()
      update_attrs = %{amount: "some updated amount", uid: "some updated uid"}

      assert {:ok, %Smspackage{} = smspackage} = Smspackages.update_smspackage(smspackage, update_attrs)
      assert smspackage.amount == "some updated amount"
      assert smspackage.uid == "some updated uid"
    end

    test "update_smspackage/2 with invalid data returns error changeset" do
      smspackage = smspackage_fixture()
      assert {:error, %Ecto.Changeset{}} = Smspackages.update_smspackage(smspackage, @invalid_attrs)
      assert smspackage == Smspackages.get_smspackage!(smspackage.id)
    end

    test "delete_smspackage/1 deletes the smspackage" do
      smspackage = smspackage_fixture()
      assert {:ok, %Smspackage{}} = Smspackages.delete_smspackage(smspackage)
      assert_raise Ecto.NoResultsError, fn -> Smspackages.get_smspackage!(smspackage.id) end
    end

    test "change_smspackage/1 returns a smspackage changeset" do
      smspackage = smspackage_fixture()
      assert %Ecto.Changeset{} = Smspackages.change_smspackage(smspackage)
    end
  end
end
