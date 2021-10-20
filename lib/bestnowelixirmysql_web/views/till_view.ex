defmodule BestnowelixirmysqlWeb.TillView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.TillView

  def render("index.json", %{tills: tills}) do
    %{data: render_many(tills, TillView, "till.json")}
  end

  def render("show.json", %{till: till}) do
    %{data: render_one(till, TillView, "till.json")}
  end

  def render("till.json", %{till: till}) do
    %{
      transLoID: till.transLoID,
      TransID: till."TransID",
      TransTime: till."TransTime",
      TransAmount: till."TransAmount",
      BusinessShortCode: till."BusinessShortCode",
      OrgAccountBalance: till."OrgAccountBalance",
      MSISDN: till."MSISDN",
      FirstName: till."FirstName",
      MiddleName: till."MiddleName",
      LastName: till."LastName",
      TransactionType: till."TransactionType",
      TransDate: till."TransDate",
      InvoiceNumber: till."InvoiceNumber",
      BillRefNumber: till."BillRefNumber",
      OrgAccountBalance: till."OrgAccountBalance",
      ThirdPartyTransID: till."ThirdPartyTransID"
    }
  end
end
