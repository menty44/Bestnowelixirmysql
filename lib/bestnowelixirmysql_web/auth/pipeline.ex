defmodule BestnowelixirmysqlWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
      otp_app: :bestnowelixirmysql,
      module: BestnowelixirmysqlWeb.Auth.Guardian,
      error_handler: BestnowelixirmysqlWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end