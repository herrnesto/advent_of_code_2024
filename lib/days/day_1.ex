defmodule Aoc2024.Days.Day1 do
  @moduledoc """
  Solution for Day 1
  """

  alias Aoc2024.Helpers

  def solve(day) do
    input =
      Helpers.read_input(day)
      |> String.split("\n")
      |> Enum.reduce([[], []], fn line, [list_a, list_b] ->
        [a, b] = String.split(line)
        {a, _} = Integer.parse(a)
        {b, _} = Integer.parse(b)
        [list_a ++ [a], list_b ++ [b]]
      end)

    part1 = solve_part1(input)
    part2 = solve_part2(input)
    IO.puts("Part 1: #{part1}")
    IO.puts("Part 2: #{part2}")
  end

  defp solve_part1([list_a, list_b]) do
    list_a = Enum.sort(list_a)
    list_b = Enum.sort(list_b)

    Enum.zip(list_a, list_b)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  defp solve_part2([list_a, list_b]) do
    list_a
    |> Enum.map(fn x ->
      list_b
      |> Enum.filter(fn y -> y == x end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end
end
