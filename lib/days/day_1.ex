defmodule Aoc2024.Days.Day1 do
  @moduledoc """
  Solution for Day 1
  """

  alias Aoc2024.Helpers

  def solve(day) do
    input = Helpers.read_input(day)
    dbg input
    part1 = solve_part1(input)
    part2 = solve_part2(input)
    IO.puts("Part 1: #{part1}")
    IO.puts("Part 2: #{part2}")
  end

  # Implement solutions for part 1 and part 2
  defp solve_part1(input) do
    # Your solution for part 1
    input |> String.split("\n") |> Enum.map(&String.to_integer/1) |> Enum.sum()
  end

  defp solve_part2(input) do
    # Your solution for part 2
    input |> String.split("\n") |> Enum.map(&String.to_integer/1) |> Enum.product()
  end

  # Helper function to read input file
end
