defmodule Bestnowelixirmysql.MobileaccountsTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Mobileaccounts

  describe "mobileusers" do
    alias Bestnowelixirmysql.Mobileaccounts.Mobileuser

    import Bestnowelixirmysql.MobileaccountsFixtures

    @invalid_attrs %{firstname: nil, lastname: nil, password_hash: nil, phone: nil}

    test "list_mobileusers/0 returns all mobileusers" do
      mobileuser = mobileuser_fixture()
      assert Mobileaccounts.list_mobileusers() == [mobileuser]
    end

    test "get_mobileuser!/1 returns the mobileuser with given id" do
      mobileuser = mobileuser_fixture()
      assert Mobileaccounts.get_mobileuser!(mobileuser.id) == mobileuser
    end

    test "create_mobileuser/1 with valid data creates a mobileuser" do
      valid_attrs = %{
        firstname: "some firstname",
        lastname: "some lastname",
        password_hash: "some password_hash",
        phone: "some phone"
      }

      assert {:ok, %Mobileuser{} = mobileuser} = Mobileaccounts.create_mobileuser(valid_attrs)
      assert mobileuser.firstname == "some firstname"
      assert mobileuser.lastname == "some lastname"
      assert mobileuser.password_hash == "some password_hash"
      assert mobileuser.phone == "some phone"
    end

    test "create_mobileuser/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Mobileaccounts.create_mobileuser(@invalid_attrs)
    end

    test "update_mobileuser/2 with valid data updates the mobileuser" do
      mobileuser = mobileuser_fixture()

      update_attrs = %{
        firstname: "some updated firstname",
        lastname: "some updated lastname",
        password_hash: "some updated password_hash",
        phone: "some updated phone"
      }

      assert {:ok, %Mobileuser{} = mobileuser} =
               Mobileaccounts.update_mobileuser(mobileuser, update_attrs)

      assert mobileuser.firstname == "some updated firstname"
      assert mobileuser.lastname == "some updated lastname"
      assert mobileuser.password_hash == "some updated password_hash"
      assert mobileuser.phone == "some updated phone"
    end

    test "update_mobileuser/2 with invalid data returns error changeset" do
      mobileuser = mobileuser_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Mobileaccounts.update_mobileuser(mobileuser, @invalid_attrs)

      assert mobileuser == Mobileaccounts.get_mobileuser!(mobileuser.id)
    end

    test "delete_mobileuser/1 deletes the mobileuser" do
      mobileuser = mobileuser_fixture()
      assert {:ok, %Mobileuser{}} = Mobileaccounts.delete_mobileuser(mobileuser)
      assert_raise Ecto.NoResultsError, fn -> Mobileaccounts.get_mobileuser!(mobileuser.id) end
    end

    test "change_mobileuser/1 returns a mobileuser changeset" do
      mobileuser = mobileuser_fixture()
      assert %Ecto.Changeset{} = Mobileaccounts.change_mobileuser(mobileuser)
    end
  end
end
