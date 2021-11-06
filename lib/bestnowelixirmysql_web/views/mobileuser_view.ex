defmodule BestnowelixirmysqlWeb.MobileuserView do
  use BestnowelixirmysqlWeb, :view
  alias BestnowelixirmysqlWeb.MobileuserView

  def render("index.json", %{mobileusers: mobileusers}) do
    %{data: render_many(mobileusers, MobileuserView, "mobileuser.json")}
  end

  def render("show.json", %{mobileuser: mobileuser}) do
    %{data: render_one(mobileuser, MobileuserView, "mobileuser.json")}
  end

  def render("mobileuser.json", %{mobileuser: mobileuser}) do
    %{
      id: mobileuser.id,
      password_hash: mobileuser.password_hash,
      phone: mobileuser.phone,
      firstname: mobileuser.firstname,
      lastname: mobileuser.lastname,
      mode: mobileuser.mode,
      role: mobileuser.role
    }
  end

  def render("sign.json", %{mobileuser: mobileuser}) do
    %{data: render_one(mobileuser, MobileuserView, "login.json")}
  end

  #  def render("login.json", %{mobileuser: mobileuser, token: token}) do
  def render("login.json", %{mobileuser: mobileuser, token: token}) do
    %{
      id: mobileuser.id,
      password_hash: mobileuser.password_hash,
      phone: mobileuser.phone,
      firstname: mobileuser.firstname,
      lastname: mobileuser.lastname,
      mode: mobileuser.mode,
      role: mobileuser.role,
      token: token
    }
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end
end
