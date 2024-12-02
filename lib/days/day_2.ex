defmodule Aoc2024.Days.Day2 do
  require Logger
  alias Aoc2024.Helpers

  require Logger

  def solve(day) do
    input =
      Helpers.read_input(day)
      |> String.split("\n")
      |> Enum.map(&String.split/1)

    IO.puts("Part 1: #{solve_part1(input)}")
    IO.puts("Part 2: #{solve_part2(input)}")
  end

  defp solve_part1(input) do
    input
    |> Enum.map(&validate_sequence/1)
    |> Enum.count(fn x -> x == true end)
  end

  def validate_sequence(sequence) do
    sequence
    |> Enum.map(&Helpers.parse_number/1)
    |> Enum.reduce_while({true, nil, nil}, &process_sequence/2)
    |> elem(0)
  end

  defp process_sequence(number, {result, inc_dec, prev}) do
    cond do
      !result ->
        {:halt, {false, inc_dec, prev}}

      is_nil(prev) ->
        {:cont, {true, nil, number}}

      abs(number - prev) > 3 or number == prev ->
        {:halt, {false, inc_dec, number}}

      true ->
        current_inc_dec = determine_trend(number, prev)

        if inc_dec == nil or inc_dec == current_inc_dec do
          {:cont, {true, current_inc_dec, number}}
        else
          {:halt, {false, current_inc_dec, number}}
        end
    end
  end

  defp determine_trend(number, prev) do
    cond do
      number > prev -> :increase
      number < prev -> :decrease
      true -> :unchanged
    end
  end

  defp solve_part2(input) do
    input
    |> Enum.map(&validate_sequence_part_2/1)
    |> Enum.count(fn {unsafe_levels, _, _} -> unsafe_levels - 1 <= 0 end)
    |> dbg
  end

  defp validate_sequence_part_2(sequence) do
    sequence
    |> Enum.map(&Helpers.parse_number/1)
    |> Enum.reduce_while({0, nil, nil}, &process_sequence_part_2/2)
  end

  defp process_sequence_part_2(number, {unsafe_levels, inc_dec, prev}) do
    cond do
      is_nil(prev) ->
        {:cont, {unsafe_levels, nil, number}}

      abs(number - prev) > 3 or number == prev ->
        {:cont, {unsafe_levels + 1, inc_dec, number}}

      true ->
        current_inc_dec = determine_trend(number, prev)

        if inc_dec == nil or inc_dec == current_inc_dec do
          {:cont, {unsafe_levels, current_inc_dec, number}}
        else
          {:cont, {unsafe_levels + 1, current_inc_dec, number}}
        end
    end
  end
end
