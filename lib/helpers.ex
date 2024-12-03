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

  def print_title(day) do
    IO.puts([
      "\n\e[1;36m",
      "╔════════════════════════════════════╗\n",
      "║  ",
      "Advent of Code 2024 - Tag #{day}",
      "       ║\n",
      "╚════════════════════════════════════╝",
      "\e[0m\n"
    ])
  end

  def print_result(label, result, color) do
    color_code =
      case color do
        :green -> "\e[1;32m"
        :blue -> "\e[1;34m"
        :red -> "\e[1;31m"
        _ -> "\e[0m"
      end

    IO.puts([
      color_code,
      "● #{label}: ",
      "\e[1;37m",
      "#{result}",
      "\e[0m"
    ])
  end
end
