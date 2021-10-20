defmodule Bestnowelixirmysql.Repo do
  use Ecto.Repo,
    otp_app: :bestnowelixirmysql,
    adapter: Ecto.Adapters.MyXQL
end
