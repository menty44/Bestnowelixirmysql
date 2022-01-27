defmodule Bestnowelixirmysql.Task do
  use Timex

  alias Bestnowelixirmysql.Subscriptions
  alias Bestnowelixirmysql.Subscriptions.Subscription

  def work do
    # File.write("/tmp/quantum_phoenix.txt", "#{Timex.now}", [:append])
    subscriptions = Subscriptions.l
    IO.inspect "Elixir.Quantum.ExecutionBroadcaster #{Timex.now()} "
  end
end
