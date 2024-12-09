defmodule Aoc2024.Days.Day6 do
  alias Aoc2024.Helpers

  # up right down left
  @directions [
    {0, -1},
    {1, 0},
    {0, 1},
    {-1, 0}
  ]

  @directions_count length(@directions)

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

    explore(start_position, input, MapSet.new(), 0)
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
    new_index = if dir_index + 1 < @directions_count, do: dir_index + 1, else: 0

    {true, new_index}
  end

  defp change_direction(nil, _), do: nil

  defp change_direction(_, dir_index), do: {false, dir_index}

  defp is_obstacle?({x, y}, _) when x < 0 or y < 0, do: nil

  defp is_obstacle?({x, y}, map) do
    case Enum.at(map, y) do
      nil ->
        nil

      row ->
        case String.at(row, x) do
          "#" -> true
          nil -> nil
          _ -> false
        end
    end
  end

  def explore(position, map, travelled_path, dir_index) do
    travelled_path = MapSet.put(travelled_path, position)

      new_position =
        position
        |> move_position(get_direction(dir_index))

      new_position
      |> is_obstacle?(map)
      |> change_direction(dir_index)
      |> case do
        {true, new_dir_index} ->
          explore(position, map, travelled_path, new_dir_index)

        nil ->
          visualize_map(map, travelled_path)
          end_process(travelled_path)

        _ ->
          explore(new_position, map, travelled_path, dir_index)
      end
  end

  defp end_process(travelled_path), do: Enum.count(travelled_path)

  defp visualize_map(map, travelled_path) do
    map
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {char, x} ->
        if MapSet.member?(travelled_path, {x, y}), do: "X", else: char
      end)
      |> Enum.join("")
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end
end
