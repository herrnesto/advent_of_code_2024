defmodule Aoc2024 do
  # Main entry point for running a specific day's solution
  def run(day) do
    module = Module.concat(__MODULE__, "Days.Day#{day}")

    case Code.ensure_loaded?(module) do
      true ->
        module.solve(day)

      false ->
        IO.puts("Day #{day} is not yet implemented.")
    end
  end
end
