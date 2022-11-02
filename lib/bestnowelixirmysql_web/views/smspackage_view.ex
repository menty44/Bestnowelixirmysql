defmodule BestnowelixirmysqlWeb.SmspackageView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.SmspackageView

  def render("index.json", %{smspackages: smspackages}) do
    %{data: render_many(smspackages, SmspackageView, "smspackage.json")}
  end

  def render("show.json", %{smspackage: smspackage}) do
    %{data: render_one(smspackage, SmspackageView, "smspackage.json")}
  end

  def render("smspackage.json", %{smspackage: smspackage}) do
    %{
      id: smspackage.id,
      uid: smspackage.uid,
      amount: smspackage.amount
    }
  end
end
