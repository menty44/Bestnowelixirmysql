defmodule BestnowelixirmysqlWeb.PaymentView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.PaymentView

  def render("index.json", %{payments: payments}) do
    %{data: render_many(payments, PaymentView, "payment.json")}
  end

  def render("show.json", %{payment: payment}) do
    %{data: render_one(payment, PaymentView, "payment.json")}
  end

  def render("payment.json", %{payment: payment}) do
    %{
      id: payment.id,
      billrefnumber: payment.billrefnumber,
      businessshortcode: payment.businessshortcode,
      firstname: payment.firstname,
      middlename: payment.middlename,
      lastname: payment.lastname,
      invoicenumber: payment.invoicenumber,
      msisdn: payment.msisdn,
      orgaccountbalance: payment.orgaccountbalance,
      thirdpartytransid: payment.thirdpartytransid,
      transamount: payment.transamount,
      transid: payment.transid,
      transtime: payment.transtime,
      transactiontype: payment.transactiontype
    }
  end
end
