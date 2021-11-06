defmodule BestnowelixirmysqlWeb.AfricastalkingtextView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.AfricastalkingtextView

  def render("index.json", %{africastalkingtexts: africastalkingtexts}) do
    %{data: render_many(africastalkingtexts, AfricastalkingtextView, "africastalkingtext.json")}
  end

  def render("show.json", %{africastalkingtext: africastalkingtext}) do
    %{data: render_one(africastalkingtext, AfricastalkingtextView, "africastalkingtext.json")}
  end

  def render("africastalkingtext.json", %{africastalkingtext: africastalkingtext}) do
    %{
      id: africastalkingtext.id,
      cost: africastalkingtext.cost,
      messageId: africastalkingtext.messageId,
      messageParts: africastalkingtext.messageParts,
      number: africastalkingtext.number,
      status: africastalkingtext.status,
      statusCode: africastalkingtext.statusCode,
      sentmessage: africastalkingtext.sentmessage
    }
  end
end
