defmodule Bestnowelixirmysql.PaymentTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Payment

  describe "mobile_payments" do
    alias Bestnowelixirmysql.Payment.Mobilepayments

    import Bestnowelixirmysql.PaymentFixtures

    @invalid_attrs %{
      BusinessShortCode: nil,
      FirstName: nil,
      LastName: nil,
      MSISDN: nil,
      MiddleName: nil,
      OrgAccountBalance: nil,
      TransAmount: nil,
      TransID: nil,
      TransTime: nil,
      transLoID: nil
    }

    test "list_mobile_payments/0 returns all mobile_payments" do
      mobilepayments = mobilepayments_fixture()
      assert Payment.list_mobile_payments() == [mobilepayments]
    end

    test "get_mobilepayments!/1 returns the mobilepayments with given id" do
      mobilepayments = mobilepayments_fixture()
      assert Payment.get_mobilepayments!(mobilepayments.id) == mobilepayments
    end

    test "create_mobilepayments/1 with valid data creates a mobilepayments" do
      valid_attrs = %{
        BusinessShortCode: "some BusinessShortCode",
        FirstName: "some FirstName",
        LastName: "some LastName",
        MSISDN: "some MSISDN",
        MiddleName: "some MiddleName",
        OrgAccountBalance: "some OrgAccountBalance",
        TransAmount: "some TransAmount",
        TransID: "some TransID",
        TransTime: "some TransTime",
        transLoID: 42
      }

      assert {:ok, %Mobilepayments{} = mobilepayments} =
               Payment.create_mobilepayments(valid_attrs)

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

      update_attrs = %{
        BusinessShortCode: "some updated BusinessShortCode",
        FirstName: "some updated FirstName",
        LastName: "some updated LastName",
        MSISDN: "some updated MSISDN",
        MiddleName: "some updated MiddleName",
        OrgAccountBalance: "some updated OrgAccountBalance",
        TransAmount: "some updated TransAmount",
        TransID: "some updated TransID",
        TransTime: "some updated TransTime",
        transLoID: 43
      }

      assert {:ok, %Mobilepayments{} = mobilepayments} =
               Payment.update_mobilepayments(mobilepayments, update_attrs)

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

      assert {:error, %Ecto.Changeset{}} =
               Payment.update_mobilepayments(mobilepayments, @invalid_attrs)

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

  describe "tills" do
    alias Bestnowelixirmysql.Payment.Mobilepayments

    import Bestnowelixirmysql.PaymentFixtures

    @invalid_attrs %{
      BillRefNumber: nil,
      BusinessShortCode: nil,
      FirstName: nil,
      InvoiceNumber: nil,
      LastName: nil,
      MSISDN: nil,
      MiddleName: nil,
      OrgAccountBalance: nil,
      ThirdPartyTransID: nil,
      TransAmount: nil,
      TransDate: nil,
      TransID: nil,
      TransTime: nil,
      TransactionType: nil,
      transLoID: nil
    }

    test "list_tills/0 returns all tills" do
      mobilepayments = mobilepayments_fixture()
      assert Payment.list_tills() == [mobilepayments]
    end

    test "get_mobilepayments!/1 returns the mobilepayments with given id" do
      mobilepayments = mobilepayments_fixture()
      assert Payment.get_mobilepayments!(mobilepayments.id) == mobilepayments
    end

    test "create_mobilepayments/1 with valid data creates a mobilepayments" do
      valid_attrs = %{
        BillRefNumber: "some BillRefNumber",
        BusinessShortCode: "some BusinessShortCode",
        FirstName: "some FirstName",
        InvoiceNumber: "some InvoiceNumber",
        LastName: "some LastName",
        MSISDN: "some MSISDN",
        MiddleName: "some MiddleName",
        OrgAccountBalance: "some OrgAccountBalance",
        ThirdPartyTransID: "some ThirdPartyTransID",
        TransAmount: "some TransAmount",
        TransDate: "some TransDate",
        TransID: "some TransID",
        TransTime: "some TransTime",
        TransactionType: "some TransactionType",
        transLoID: 42
      }

      assert {:ok, %Mobilepayments{} = mobilepayments} =
               Payment.create_mobilepayments(valid_attrs)

      assert mobilepayments.BillRefNumber == "some BillRefNumber"
      assert mobilepayments.BusinessShortCode == "some BusinessShortCode"
      assert mobilepayments.FirstName == "some FirstName"
      assert mobilepayments.InvoiceNumber == "some InvoiceNumber"
      assert mobilepayments.LastName == "some LastName"
      assert mobilepayments.MSISDN == "some MSISDN"
      assert mobilepayments.MiddleName == "some MiddleName"
      assert mobilepayments.OrgAccountBalance == "some OrgAccountBalance"
      assert mobilepayments.ThirdPartyTransID == "some ThirdPartyTransID"
      assert mobilepayments.TransAmount == "some TransAmount"
      assert mobilepayments.TransDate == "some TransDate"
      assert mobilepayments.TransID == "some TransID"
      assert mobilepayments.TransTime == "some TransTime"
      assert mobilepayments.TransactionType == "some TransactionType"
      assert mobilepayments.transLoID == 42
    end

    test "create_mobilepayments/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payment.create_mobilepayments(@invalid_attrs)
    end

    test "update_mobilepayments/2 with valid data updates the mobilepayments" do
      mobilepayments = mobilepayments_fixture()

      update_attrs = %{
        BillRefNumber: "some updated BillRefNumber",
        BusinessShortCode: "some updated BusinessShortCode",
        FirstName: "some updated FirstName",
        InvoiceNumber: "some updated InvoiceNumber",
        LastName: "some updated LastName",
        MSISDN: "some updated MSISDN",
        MiddleName: "some updated MiddleName",
        OrgAccountBalance: "some updated OrgAccountBalance",
        ThirdPartyTransID: "some updated ThirdPartyTransID",
        TransAmount: "some updated TransAmount",
        TransDate: "some updated TransDate",
        TransID: "some updated TransID",
        TransTime: "some updated TransTime",
        TransactionType: "some updated TransactionType",
        transLoID: 43
      }

      assert {:ok, %Mobilepayments{} = mobilepayments} =
               Payment.update_mobilepayments(mobilepayments, update_attrs)

      assert mobilepayments.BillRefNumber == "some updated BillRefNumber"
      assert mobilepayments.BusinessShortCode == "some updated BusinessShortCode"
      assert mobilepayments.FirstName == "some updated FirstName"
      assert mobilepayments.InvoiceNumber == "some updated InvoiceNumber"
      assert mobilepayments.LastName == "some updated LastName"
      assert mobilepayments.MSISDN == "some updated MSISDN"
      assert mobilepayments.MiddleName == "some updated MiddleName"
      assert mobilepayments.OrgAccountBalance == "some updated OrgAccountBalance"
      assert mobilepayments.ThirdPartyTransID == "some updated ThirdPartyTransID"
      assert mobilepayments.TransAmount == "some updated TransAmount"
      assert mobilepayments.TransDate == "some updated TransDate"
      assert mobilepayments.TransID == "some updated TransID"
      assert mobilepayments.TransTime == "some updated TransTime"
      assert mobilepayments.TransactionType == "some updated TransactionType"
      assert mobilepayments.transLoID == 43
    end

    test "update_mobilepayments/2 with invalid data returns error changeset" do
      mobilepayments = mobilepayments_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Payment.update_mobilepayments(mobilepayments, @invalid_attrs)

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

  describe "tills" do
    alias Bestnowelixirmysql.Payment.Till

    import Bestnowelixirmysql.PaymentFixtures

    @invalid_attrs %{
      BillRefNumber: nil,
      BusinessShortCode: nil,
      FirstName: nil,
      InvoiceNumber: nil,
      LastName: nil,
      MSISDN: nil,
      MiddleName: nil,
      OrgAccountBalance: nil,
      ThirdPartyTransID: nil,
      TransAmount: nil,
      TransDate: nil,
      TransID: nil,
      TransTime: nil,
      TransactionType: nil,
      transLoID: nil
    }

    test "list_tills/0 returns all tills" do
      till = till_fixture()
      assert Payment.list_tills() == [till]
    end

    test "get_till!/1 returns the till with given id" do
      till = till_fixture()
      assert Payment.get_till!(till.id) == till
    end

    test "create_till/1 with valid data creates a till" do
      valid_attrs = %{
        BillRefNumber: "some BillRefNumber",
        BusinessShortCode: "some BusinessShortCode",
        FirstName: "some FirstName",
        InvoiceNumber: "some InvoiceNumber",
        LastName: "some LastName",
        MSISDN: "some MSISDN",
        MiddleName: "some MiddleName",
        OrgAccountBalance: "some OrgAccountBalance",
        ThirdPartyTransID: "some ThirdPartyTransID",
        TransAmount: "some TransAmount",
        TransDate: "some TransDate",
        TransID: "some TransID",
        TransTime: "some TransTime",
        TransactionType: "some TransactionType",
        transLoID: 42
      }

      assert {:ok, %Till{} = till} = Payment.create_till(valid_attrs)
      assert till.BillRefNumber == "some BillRefNumber"
      assert till.BusinessShortCode == "some BusinessShortCode"
      assert till.FirstName == "some FirstName"
      assert till.InvoiceNumber == "some InvoiceNumber"
      assert till.LastName == "some LastName"
      assert till.MSISDN == "some MSISDN"
      assert till.MiddleName == "some MiddleName"
      assert till.OrgAccountBalance == "some OrgAccountBalance"
      assert till.ThirdPartyTransID == "some ThirdPartyTransID"
      assert till.TransAmount == "some TransAmount"
      assert till.TransDate == "some TransDate"
      assert till.TransID == "some TransID"
      assert till.TransTime == "some TransTime"
      assert till.TransactionType == "some TransactionType"
      assert till.transLoID == 42
    end

    test "create_till/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payment.create_till(@invalid_attrs)
    end

    test "update_till/2 with valid data updates the till" do
      till = till_fixture()

      update_attrs = %{
        BillRefNumber: "some updated BillRefNumber",
        BusinessShortCode: "some updated BusinessShortCode",
        FirstName: "some updated FirstName",
        InvoiceNumber: "some updated InvoiceNumber",
        LastName: "some updated LastName",
        MSISDN: "some updated MSISDN",
        MiddleName: "some updated MiddleName",
        OrgAccountBalance: "some updated OrgAccountBalance",
        ThirdPartyTransID: "some updated ThirdPartyTransID",
        TransAmount: "some updated TransAmount",
        TransDate: "some updated TransDate",
        TransID: "some updated TransID",
        TransTime: "some updated TransTime",
        TransactionType: "some updated TransactionType",
        transLoID: 43
      }

      assert {:ok, %Till{} = till} = Payment.update_till(till, update_attrs)
      assert till.BillRefNumber == "some updated BillRefNumber"
      assert till.BusinessShortCode == "some updated BusinessShortCode"
      assert till.FirstName == "some updated FirstName"
      assert till.InvoiceNumber == "some updated InvoiceNumber"
      assert till.LastName == "some updated LastName"
      assert till.MSISDN == "some updated MSISDN"
      assert till.MiddleName == "some updated MiddleName"
      assert till.OrgAccountBalance == "some updated OrgAccountBalance"
      assert till.ThirdPartyTransID == "some updated ThirdPartyTransID"
      assert till.TransAmount == "some updated TransAmount"
      assert till.TransDate == "some updated TransDate"
      assert till.TransID == "some updated TransID"
      assert till.TransTime == "some updated TransTime"
      assert till.TransactionType == "some updated TransactionType"
      assert till.transLoID == 43
    end

    test "update_till/2 with invalid data returns error changeset" do
      till = till_fixture()
      assert {:error, %Ecto.Changeset{}} = Payment.update_till(till, @invalid_attrs)
      assert till == Payment.get_till!(till.id)
    end

    test "delete_till/1 deletes the till" do
      till = till_fixture()
      assert {:ok, %Till{}} = Payment.delete_till(till)
      assert_raise Ecto.NoResultsError, fn -> Payment.get_till!(till.id) end
    end

    test "change_till/1 returns a till changeset" do
      till = till_fixture()
      assert %Ecto.Changeset{} = Payment.change_till(till)
    end
  end

  describe "paybill" do
    alias Bestnowelixirmysql.Payment.Paybill

    import Bestnowelixirmysql.PaymentFixtures

    @invalid_attrs %{
      BillRefNumber: nil,
      BusinessShortCode: nil,
      FirstName: nil,
      InvoiceNumber: nil,
      LastName: nil,
      MSISDN: nil,
      MiddleName: nil,
      OrgAccountBalance: nil,
      ThirdPartyTransID: nil,
      TransAmount: nil,
      TransDate: nil,
      TransID: nil,
      TransTime: nil,
      TransactionType: nil,
      transLoID: nil
    }

    test "list_paybill/0 returns all paybill" do
      paybill = paybill_fixture()
      assert Payment.list_paybill() == [paybill]
    end

    test "get_paybill!/1 returns the paybill with given id" do
      paybill = paybill_fixture()
      assert Payment.get_paybill!(paybill.id) == paybill
    end

    test "create_paybill/1 with valid data creates a paybill" do
      valid_attrs = %{
        BillRefNumber: "some BillRefNumber",
        BusinessShortCode: "some BusinessShortCode",
        FirstName: "some FirstName",
        InvoiceNumber: "some InvoiceNumber",
        LastName: "some LastName",
        MSISDN: "some MSISDN",
        MiddleName: "some MiddleName",
        OrgAccountBalance: "some OrgAccountBalance",
        ThirdPartyTransID: "some ThirdPartyTransID",
        TransAmount: "some TransAmount",
        TransDate: "some TransDate",
        TransID: "some TransID",
        TransTime: "some TransTime",
        TransactionType: "some TransactionType",
        transLoID: 42
      }

      assert {:ok, %Paybill{} = paybill} = Payment.create_paybill(valid_attrs)
      assert paybill.BillRefNumber == "some BillRefNumber"
      assert paybill.BusinessShortCode == "some BusinessShortCode"
      assert paybill.FirstName == "some FirstName"
      assert paybill.InvoiceNumber == "some InvoiceNumber"
      assert paybill.LastName == "some LastName"
      assert paybill.MSISDN == "some MSISDN"
      assert paybill.MiddleName == "some MiddleName"
      assert paybill.OrgAccountBalance == "some OrgAccountBalance"
      assert paybill.ThirdPartyTransID == "some ThirdPartyTransID"
      assert paybill.TransAmount == "some TransAmount"
      assert paybill.TransDate == "some TransDate"
      assert paybill.TransID == "some TransID"
      assert paybill.TransTime == "some TransTime"
      assert paybill.TransactionType == "some TransactionType"
      assert paybill.transLoID == 42
    end

    test "create_paybill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payment.create_paybill(@invalid_attrs)
    end

    test "update_paybill/2 with valid data updates the paybill" do
      paybill = paybill_fixture()

      update_attrs = %{
        BillRefNumber: "some updated BillRefNumber",
        BusinessShortCode: "some updated BusinessShortCode",
        FirstName: "some updated FirstName",
        InvoiceNumber: "some updated InvoiceNumber",
        LastName: "some updated LastName",
        MSISDN: "some updated MSISDN",
        MiddleName: "some updated MiddleName",
        OrgAccountBalance: "some updated OrgAccountBalance",
        ThirdPartyTransID: "some updated ThirdPartyTransID",
        TransAmount: "some updated TransAmount",
        TransDate: "some updated TransDate",
        TransID: "some updated TransID",
        TransTime: "some updated TransTime",
        TransactionType: "some updated TransactionType",
        transLoID: 43
      }

      assert {:ok, %Paybill{} = paybill} = Payment.update_paybill(paybill, update_attrs)
      assert paybill.BillRefNumber == "some updated BillRefNumber"
      assert paybill.BusinessShortCode == "some updated BusinessShortCode"
      assert paybill.FirstName == "some updated FirstName"
      assert paybill.InvoiceNumber == "some updated InvoiceNumber"
      assert paybill.LastName == "some updated LastName"
      assert paybill.MSISDN == "some updated MSISDN"
      assert paybill.MiddleName == "some updated MiddleName"
      assert paybill.OrgAccountBalance == "some updated OrgAccountBalance"
      assert paybill.ThirdPartyTransID == "some updated ThirdPartyTransID"
      assert paybill.TransAmount == "some updated TransAmount"
      assert paybill.TransDate == "some updated TransDate"
      assert paybill.TransID == "some updated TransID"
      assert paybill.TransTime == "some updated TransTime"
      assert paybill.TransactionType == "some updated TransactionType"
      assert paybill.transLoID == 43
    end

    test "update_paybill/2 with invalid data returns error changeset" do
      paybill = paybill_fixture()
      assert {:error, %Ecto.Changeset{}} = Payment.update_paybill(paybill, @invalid_attrs)
      assert paybill == Payment.get_paybill!(paybill.id)
    end

    test "delete_paybill/1 deletes the paybill" do
      paybill = paybill_fixture()
      assert {:ok, %Paybill{}} = Payment.delete_paybill(paybill)
      assert_raise Ecto.NoResultsError, fn -> Payment.get_paybill!(paybill.id) end
    end

    test "change_paybill/1 returns a paybill changeset" do
      paybill = paybill_fixture()
      assert %Ecto.Changeset{} = Payment.change_paybill(paybill)
    end
  end
end
