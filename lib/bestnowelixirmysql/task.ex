defmodule Bestnowelixirmysql.Task do
  use Timex
  @moduledoc false
  def work do
    # File.write("/tmp/quantum_phoenix.txt", "#{Timex.now}", [:append])
    IO.inspect "Elixir.Quantum.ExecutionBroadcaster #{Timex.now()} "
  end
end
