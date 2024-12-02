defmodule Aoc2024.Helpers do
  def read_input(day) do
    "priv/inputs/day_#{day}.txt"
    |> File.read!()
    |> String.trim()
  end

  def parse_number(number) do
    {parsed, _} = Integer.parse(number)
    parsed
  end
end
