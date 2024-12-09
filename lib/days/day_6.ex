defmodule Aoc2024.Days.Day6 do
  alias Aoc2024.Helpers

  # up right down left
  @directions [
    {0, -1},
    {1, 0},
    {0, 1},
    {-1, 0}
  ]
  def solve(day) do
    input =
      Helpers.read_input(day)
      |> String.split("\n")

    Helpers.print_title(day)
    Helpers.print_result("Teil 1", solve_part1(input), :green)
    Helpers.print_result("Teil 2", solve_part2(input), :blue)
  end

  defp solve_part1(input) do
    start_position =
      get_start_position(input)

    do_process(start_position, input, 0, 1)
  end

  defp solve_part2(_) do
    "___"
  end

  defp get_start_position(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce_while({nil, nil}, fn {row, row_index}, row_acc ->
      row
      |> String.split("", trim: true)
      |> Enum.find_index(fn char -> char == "^" end)
      |> case do
        nil -> {:cont, row_acc}
        index -> {:halt, {index, row_index}}
      end
    end)
  end

  defp move_position({y, x}, {y_dir, x_dir}) do
    {y + y_dir, x + x_dir}
  end

  defp get_direction(dir_index), do: Enum.at(@directions, dir_index)

  defp change_direction(true, dir_index) do
    new_index = if dir_index + 1 < Enum.count(@directions), do: dir_index + 1, else: 0

    {true, new_index}
  end

  defp change_direction(nil, _), do: nil

  defp change_direction(_, dir_index), do: {false, dir_index}

  defp is_obstacle?({x, y}, map) do
    with {:ok, row} <- Enum.fetch(map, y),
         chars = String.split(row, "", trim: true),
         {:ok, char} <- Enum.fetch(chars, x) do
      IO.inspect(char)

      if char == "#" do
        true
      else
        false
      end
    else
      _ -> nil
    end
  end

  def do_process(position, _, dir_index, 200) do
    dbg({position, dir_index, 1000})
  end

  def do_process(position, map, dir_index, step) do
    IO.inspect({position, step}, label: "position")

    new_position =
      position
      |> move_position(get_direction(dir_index))

    new_position
    |> is_obstacle?(map)
    |> change_direction(dir_index)
    |> case do
      {true, new_dir_index} -> do_process(position, map, new_dir_index, step)
      nil -> end_process(step - 1)
      _ -> do_process(new_position, map, dir_index, step + 1)
    end
  end

  defp end_process(step), do: step
end
