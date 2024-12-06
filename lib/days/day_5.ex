defmodule Aoc2024.Days.Day5 do
  alias Aoc2024.Helpers

  def solve(day) do
    input =
      Helpers.read_input(day)
      |> String.split("\n")

    Helpers.print_title(day)
    Helpers.print_result("Teil 1", solve_part1(input), :green)
    Helpers.print_result("Teil 2", solve_part2(input), :blue)
  end

  defp solve_part1(_) do
    "___"
  end

  defp solve_part2(_) do
    "___"
  end
end
