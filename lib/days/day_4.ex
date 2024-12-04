defmodule Aoc2024.Days.Day4 do
  alias Aoc2024.Helpers

  @searchterm String.graphemes("XMAS")

  @directions [
    {1, 0},
    {-1, 0},
    {0, 1},
    {0, -1},
    {1, 1},
    {-1, -1},
    {1, -1},
    {-1, 1}
  ]

  def solve(day) do
    input =
      Helpers.read_input(day)
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)

    Helpers.print_title(day)
    Helpers.print_result("Teil 1", solve_part1(input), :green)
    Helpers.print_result("Teil 2", solve_part2(input), :blue)
  end

  defp solve_part1(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(0, fn {row, row_index}, row_acc ->
      sum =
        row
        |> Enum.with_index()
        |> Enum.reduce(0, fn {_, line_index}, line_acc ->
          needle = {row_index, line_index}

          sum =
            @directions
            |> Enum.map(fn dir ->
              if process_search(input, needle, dir), do: 1, else: 0
            end)
            |> Enum.sum()

          line_acc + sum
        end)

      row_acc + sum
    end)
  end

  defp solve_part2(_) do
    "___"
  end

  defp process_search(matrix, position, direction, index \\ 0)
  defp process_search(_, _, _, index) when index == 4, do: true

  defp process_search(matrix, position, direction, index) do
    with true <- match?(matrix, position, Enum.at(@searchterm, index)),
         new_position <- shift_position(position, direction),
         true <- validate_position(new_position) do
      process_search(matrix, new_position, direction, index + 1)
    else
      _ -> false
    end
  end

  defp validate_position({y, x}) when y >= -1 and x >= -1, do: true
  defp validate_position(_), do: false

  defp shift_position({y, x}, {y_dir, x_dir}) do
    {y + y_dir, x + x_dir}
  end

  defp match?(matrix, {y, x}, search) do
    with row when is_list(row) <- Enum.at(matrix, y),
         letter when is_binary(letter) <- Enum.at(row, x) do
      letter == search
    else
      _ -> false
    end
  end
end
