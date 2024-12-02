defmodule Mix.Tasks.Aoc.Run do
  use Mix.Task

  @shortdoc "Run a specific day's solution for Advent of Code"

  @impl Mix.Task
  def run(args) do
    case parse_args(args) do
      {:ok, day} ->
        # Call the corresponding AdventOfCode module
        Aoc2024.run(day)

      {:error, reason} ->
        Mix.shell().error(reason)
        print_usage()
    end
  end

  defp parse_args([day | _rest]) do
    day =
      case Integer.parse(day) do
        {day, ""} when day > 0 -> day
        _ -> {:error, "Invalid day format. Must be a positive integer."}
      end

    {:ok, day}
  end

  defp parse_args(_), do: {:error, "Invalid arguments. Day must be provided."}

  defp print_usage do
    Mix.shell().info("""
    Usage:
        mix aoc.run <day>

    Options:
        <day>        The day number of the Advent of Code challenge.
    """)
  end
end
