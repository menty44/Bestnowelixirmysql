defmodule Bestnowelixirmysql.Task do
  use Timex

  alias Bestnowelixirmysql.Subscriptions
  alias Bestnowelixirmysql.Subscriptions.Subscription

  def work do
    Subscriptions.bulk_update_subscriptions()
    IO.inspect "Quantum.ExecutionBroadcaster #{Timex.now()} <> DEDUCT DAYS "
  end

  def deactivate_subscriber do
    Subscriptions.bulk_deactivate_low_fund_subscriptions()
    IO.inspect "Quantum.ExecutionBroadcaster #{Timex.now()} <> DEACTIVATE ACCOUNT"
  end
end
