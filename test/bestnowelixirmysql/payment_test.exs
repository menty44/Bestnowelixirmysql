defmodule Bestnowelixirmysql.PaymentTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Payment

  describe "mobile_payments" do
    alias Bestnowelixirmysql.Payment.Mobilepayments

    import Bestnowelixirmysql.PaymentFixtures

    @invalid_attrs %{BusinessShortCode: nil, FirstName: nil, LastName: nil, MSISDN: nil, MiddleName: nil, OrgAccountBalance: nil, TransAmount: nil, TransID: nil, TransTime: nil, transLoID: nil}

    test "list_mobile_payments/0 returns all mobile_payments" do
      mobilepayments = mobilepayments_fixture()
      assert Payment.list_mobile_payments() == [mobilepayments]
    end

    test "get_mobilepayments!/1 returns the mobilepayments with given id" do
      mobilepayments = mobilepayments_fixture()
      assert Payment.get_mobilepayments!(mobilepayments.id) == mobilepayments
    end

    test "create_mobilepayments/1 with valid data creates a mobilepayments" do
      valid_attrs = %{BusinessShortCode: "some BusinessShortCode", FirstName: "some FirstName", LastName: "some LastName", MSISDN: "some MSISDN", MiddleName: "some MiddleName", OrgAccountBalance: "some OrgAccountBalance", TransAmount: "some TransAmount", TransID: "some TransID", TransTime: "some TransTime", transLoID: 42}

      assert {:ok, %Mobilepayments{} = mobilepayments} = Payment.create_mobilepayments(valid_attrs)
      assert mobilepayments.BusinessShortCode == "some BusinessShortCode"
      assert mobilepayments.FirstName == "some FirstName"
      assert mobilepayments.LastName == "some LastName"
      assert mobilepayments.MSISDN == "some MSISDN"
      assert mobilepayments.MiddleName == "some MiddleName"
      assert mobilepayments.OrgAccountBalance == "some OrgAccountBalance"
      assert mobilepayments.TransAmount == "some TransAmount"
      assert mobilepayments.TransID == "some TransID"
      assert mobilepayments.TransTime == "some TransTime"
      assert mobilepayments.transLoID == 42
    end

    test "create_mobilepayments/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payment.create_mobilepayments(@invalid_attrs)
    end

    test "update_mobilepayments/2 with valid data updates the mobilepayments" do
      mobilepayments = mobilepayments_fixture()
      update_attrs = %{BusinessShortCode: "some updated BusinessShortCode", FirstName: "some updated FirstName", LastName: "some updated LastName", MSISDN: "some updated MSISDN", MiddleName: "some updated MiddleName", OrgAccountBalance: "some updated OrgAccountBalance", TransAmount: "some updated TransAmount", TransID: "some updated TransID", TransTime: "some updated TransTime", transLoID: 43}

      assert {:ok, %Mobilepayments{} = mobilepayments} = Payment.update_mobilepayments(mobilepayments, update_attrs)
      assert mobilepayments.BusinessShortCode == "some updated BusinessShortCode"
      assert mobilepayments.FirstName == "some updated FirstName"
      assert mobilepayments.LastName == "some updated LastName"
      assert mobilepayments.MSISDN == "some updated MSISDN"
      assert mobilepayments.MiddleName == "some updated MiddleName"
      assert mobilepayments.OrgAccountBalance == "some updated OrgAccountBalance"
      assert mobilepayments.TransAmount == "some updated TransAmount"
      assert mobilepayments.TransID == "some updated TransID"
      assert mobilepayments.TransTime == "some updated TransTime"
      assert mobilepayments.transLoID == 43
    end

    test "update_mobilepayments/2 with invalid data returns error changeset" do
      mobilepayments = mobilepayments_fixture()
      assert {:error, %Ecto.Changeset{}} = Payment.update_mobilepayments(mobilepayments, @invalid_attrs)
      assert mobilepayments == Payment.get_mobilepayments!(mobilepayments.id)
    end

    test "delete_mobilepayments/1 deletes the mobilepayments" do
      mobilepayments = mobilepayments_fixture()
      assert {:ok, %Mobilepayments{}} = Payment.delete_mobilepayments(mobilepayments)
      assert_raise Ecto.NoResultsError, fn -> Payment.get_mobilepayments!(mobilepayments.id) end
    end

    test "change_mobilepayments/1 returns a mobilepayments changeset" do
      mobilepayments = mobilepayments_fixture()
      assert %Ecto.Changeset{} = Payment.change_mobilepayments(mobilepayments)
    end
  end
end
