defmodule BestnowelixirmysqlWeb.PaybillView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.PaybillView

  def render("index.json", %{paybill: paybill}) do
    %{data: render_many(paybill, PaybillView, "paybill.json")}
  end

  def render("show.json", %{paybill: paybill}) do
    %{data: render_one(paybill, PaybillView, "paybill.json")}
  end

  def render("paybill.json", %{paybill: paybill}) do
    %{
      transLoID: paybill.transLoID,
      TransID: paybill."TransID",
      TransTime: paybill."TransTime",
      TransAmount: paybill."TransAmount",
      BusinessShortCode: paybill."BusinessShortCode",
      OrgAccountBalance: paybill."OrgAccountBalance",
      MSISDN: paybill."MSISDN",
      FirstName: paybill."FirstName",
      MiddleName: paybill."MiddleName",
      LastName: paybill."LastName",
      TransactionType: paybill."TransactionType",
      TransDate: paybill."TransDate",
      InvoiceNumber: paybill."InvoiceNumber",
      BillRefNumber: paybill."BillRefNumber",
      OrgAccountBalance: paybill."OrgAccountBalance",
      ThirdPartyTransID: paybill."ThirdPartyTransID"
    }
  end

  def render("phone.json", %{paybill: paybill, till: till}) do
    [
      %{paybill: render_many(paybill, PaybillView, "paybill.json")},
      %{till: render_many(till, BestnowelixirmysqlWeb.TillView, "till.json")}
    ]
  end

  def render("error.json", %{message: reason}) do
    %{data: reason}
  end
end
