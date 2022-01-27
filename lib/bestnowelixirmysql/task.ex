defmodule Bestnowelixirmysql.Task do
  @moduledoc false
  def work do
    File.write("/tmp/quantum_phoenix.txt", "#{Timex.now}", [:append])
  end
end
