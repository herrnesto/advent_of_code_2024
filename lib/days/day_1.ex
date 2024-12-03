defmodule Aoc2024.Days.Day1 do
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

    Helpers.print_title(day)
    Helpers.print_result("Teil 1", solve_part1(input), :green)
    Helpers.print_result("Teil 2", solve_part2(input), :blue)
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
