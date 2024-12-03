defmodule Aoc2024.Days.Day3 do
  @moduledoc """
  Solution for Day 1
  """

  alias Aoc2024.Helpers

  def solve(day) do
    input =
      Helpers.read_input(day)
      |> String.split("\n")

    IO.puts("Day 3:")
    IO.puts("Part 1: #{solve_part1(input)}")
    IO.puts("Part 2: #{solve_part2(input)}")
  end

  defp solve_part1(input) do
    input
    |> Enum.map(&Regex.scan(~r/mul\(\d+,\d+\)/, &1))
    |> List.flatten()
    |> Enum.map(&Regex.scan(~r/\d+/, &1))
    |> Enum.map(&calc/1)
    |> Enum.sum()
  end

  defp solve_part2(input) do
    input
    |> Enum.map(&Regex.scan(~r/don't\(\)|mul\(\d+,\d+\)|do\(\)/, &1))
    |> List.flatten()
    |> Enum.reduce({0, true}, fn elem, {acc, valid} ->
      cond do
        String.starts_with?(elem, "don't") -> {acc, false}
        String.starts_with?(elem, "do") -> {acc, true}
        valid && String.starts_with?(elem, "mul") -> {acc + process_elem(elem), true}
        true -> {acc, valid}
      end
    end)
    |> elem(0)
  end

  defp process_elem(elem) do
    Regex.scan(~r/\d+/, elem)
    |> calc()
  end

  defp calc([[a], [b]]) do
    {a, _} = Integer.parse(a)
    {b, _} = Integer.parse(b)
    a * b
  end
end
