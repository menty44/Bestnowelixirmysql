defmodule BestnowelixirmysqlWeb.ConfirmationView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.ConfirmationView

  def render("index.json", %{confirmations: confirmations}) do
    %{data: render_many(confirmations, ConfirmationView, "confirmation.json")}
  end

  def render("show.json", %{confirmation: confirmation}) do
    %{data: render_one(confirmation, ConfirmationView, "confirmation.json")}
  end

  def render("confirmation.json", %{confirmation: confirmation}) do
    %{
      id: confirmation.id,
      phone: confirmation.phone,
      amount: confirmation.amount,
      mpesacode: confirmation.mpesacode
    }
  end
end
