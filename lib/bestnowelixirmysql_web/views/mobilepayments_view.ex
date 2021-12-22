defmodule BestnowelixirmysqlWeb.MobilepaymentsView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.MobilepaymentsView
  alias BestnowelixirmysqlWeb.PaymentView

  def render("index.json", %{mobile_payments: mobile_payments}) do
    %{data: render_many(mobile_payments, MobilepaymentsView, "mobilepayments.json")}
  end

  def render("show.json", %{mobilepayments: mobilepayments}) do
    %{data: render_one(mobilepayments, MobilepaymentsView, "mobilepayments.json")}
  end

  def render("show.json", %{payment: payment}) do
    %{data: render_one(payment, PaymentView, "payment.json")}
  end

  def render("mobilepayments.json", %{mobilepayments: mobilepayments}) do
    %{
      transLoID: mobilepayments.transLoID,
      TransID: mobilepayments."TransID",
      TransTime: mobilepayments."TransTime",
      TransAmount: mobilepayments."TransAmount",
      BusinessShortCode: mobilepayments."BusinessShortCode",
      OrgAccountBalance: mobilepayments."OrgAccountBalance",
      MSISDN: mobilepayments."MSISDN",
      FirstName: mobilepayments."FirstName",
      MiddleName: mobilepayments."MiddleName",
      LastName: mobilepayments."LastName"
    }
  end
end
