defmodule Bestnowelixirmysql.PaymentsTest do
  use Bestnowelixirmysql.DataCase

  alias Bestnowelixirmysql.Payments

  describe "payments" do
    alias Bestnowelixirmysql.Payments.Payment

    import Bestnowelixirmysql.PaymentsFixtures

    @invalid_attrs %{
      billrefnumber: nil,
      businessshortcode: nil,
      firstname: nil,
      invoicenumber: nil,
      lastname: nil,
      middlename: nil,
      msisdn: nil,
      orgaccountbalance: nil,
      thirdpartytransid: nil,
      transactiontype: nil,
      transamount: nil,
      transid: nil,
      transtime: nil
    }

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Payments.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Payments.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      valid_attrs = %{
        billrefnumber: "some billrefnumber",
        businessshortcode: "some businessshortcode",
        firstname: "some firstname",
        invoicenumber: "some invoicenumber",
        lastname: "some lastname",
        middlename: "some middlename",
        msisdn: "some msisdn",
        orgaccountbalance: "some orgaccountbalance",
        thirdpartytransid: "some thirdpartytransid",
        transactiontype: "some transactiontype",
        transamount: "some transamount",
        transid: "some transid",
        transtime: "some transtime"
      }

      assert {:ok, %Payment{} = payment} = Payments.create_payment(valid_attrs)
      assert payment.billrefnumber == "some billrefnumber"
      assert payment.businessshortcode == "some businessshortcode"
      assert payment.firstname == "some firstname"
      assert payment.invoicenumber == "some invoicenumber"
      assert payment.lastname == "some lastname"
      assert payment.middlename == "some middlename"
      assert payment.msisdn == "some msisdn"
      assert payment.orgaccountbalance == "some orgaccountbalance"
      assert payment.thirdpartytransid == "some thirdpartytransid"
      assert payment.transactiontype == "some transactiontype"
      assert payment.transamount == "some transamount"
      assert payment.transid == "some transid"
      assert payment.transtime == "some transtime"
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Payments.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()

      update_attrs = %{
        billrefnumber: "some updated billrefnumber",
        businessshortcode: "some updated businessshortcode",
        firstname: "some updated firstname",
        invoicenumber: "some updated invoicenumber",
        lastname: "some updated lastname",
        middlename: "some updated middlename",
        msisdn: "some updated msisdn",
        orgaccountbalance: "some updated orgaccountbalance",
        thirdpartytransid: "some updated thirdpartytransid",
        transactiontype: "some updated transactiontype",
        transamount: "some updated transamount",
        transid: "some updated transid",
        transtime: "some updated transtime"
      }

      assert {:ok, %Payment{} = payment} = Payments.update_payment(payment, update_attrs)
      assert payment.billrefnumber == "some updated billrefnumber"
      assert payment.businessshortcode == "some updated businessshortcode"
      assert payment.firstname == "some updated firstname"
      assert payment.invoicenumber == "some updated invoicenumber"
      assert payment.lastname == "some updated lastname"
      assert payment.middlename == "some updated middlename"
      assert payment.msisdn == "some updated msisdn"
      assert payment.orgaccountbalance == "some updated orgaccountbalance"
      assert payment.thirdpartytransid == "some updated thirdpartytransid"
      assert payment.transactiontype == "some updated transactiontype"
      assert payment.transamount == "some updated transamount"
      assert payment.transid == "some updated transid"
      assert payment.transtime == "some updated transtime"
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Payments.update_payment(payment, @invalid_attrs)
      assert payment == Payments.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Payments.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Payments.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Payments.change_payment(payment)
    end
  end
end
