defmodule BestnowelixirmysqlWeb.Auth.Guardian do
  use Guardian, otp_app: :bestnowelixirmysql

  #  alias FmcgBackendWeb.Accounts

#  alias FmcgBackend.Account.User
  alias Bestnowelixirmysql.Mobileaccounts.Mobileuser

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Bestnowelixirmysql.Mobileaccounts.get_mobileuser!(id)
    {:ok, resource}
  end

  def authenticate(phone, password) do
    with {:ok, user} <- Bestnowelixirmysql.Mobileaccounts.get_by_phone!(phone) do
      IO.inspect user, label: "user"
      IO.inspect user.password_hash
      case validate_password(password, user.password_hash) do
        true ->
          create_token(user)
        false ->
          {:error, :unauthorized}
      end
    end
  end

  def validate_password(password, encrypted_password) do
    check = Comeonin.Bcrypt.checkpw(password, encrypted_password)
    IO.inspect check
  end

  def create_token(user) do
    {:ok, token, _} = encode_and_sign(user)
    {:ok, user, token}
  end

end