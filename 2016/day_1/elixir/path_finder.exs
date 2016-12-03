defmodule PathFinder do
  def run(path) do
    path
    |> parse
    |> walk
    |> Map.get(:history)
  end

  def total_distance(history) do
    {x, y} = hd history
    (abs x) + (abs y)
  end

  defp parse(string) do
    string
    |> String.trim
    |> String.split(", ")
  end

  defp walk(path) do
    path
    |> List.foldl(%{x: 0, y: 0, direction: "N", history: [{0,0}]}, &move/2)
  end

  defp move(step, acc) do
    new_direction = turn(acc[:direction], step)
    number        = step |> String.next_grapheme |> elem(1) |> String.to_integer
    steps         = find_step(acc, number, new_direction)
    history       = record(acc, number, new_direction)
    Map.put(steps, :history, history)
  end

  def turn(current_direction, destination) do
    case current_direction do
      "N" -> if String.first(destination) == "R" do "E" else "W" end
      "S" -> if String.first(destination) == "R" do "W" else "E" end
      "E" -> if String.first(destination) == "R" do "S" else "N" end
      "W" -> if String.first(destination) == "R" do "N" else "S" end
      _   -> raise "Not a cardinal direction"
    end
  end

  defp find_step(start, distance, direction) do
    case direction do
      "N" -> %{x: start[:x], y: start[:y] + distance, direction: direction}
      "S" -> %{x: start[:x], y: start[:y] - distance, direction: direction}
      "E" -> %{x: start[:x] + distance, y: start[:y], direction: direction}
      "W" -> %{x: start[:x] - distance, y: start[:y], direction: direction}
      _   -> raise "Not a cardinal direction"
    end
  end

  defp record(current, distance, new_direction) do
    additions =
      case new_direction do
        "N" -> (current[:y] + 1)..(current[:y] + distance) |> Enum.map(fn y -> {current[:x], y} end)
        "S" -> (current[:y] - 1)..(current[:y] - distance) |> Enum.map(fn y -> {current[:x], y} end)
        "E" -> (current[:x] + 1)..(current[:x] + distance) |> Enum.map(fn x -> {x, current[:y]} end)
        "W" -> (current[:x] - 1)..(current[:x] - distance) |> Enum.map(fn x -> {x, current[:y]} end)
         _  -> raise "Not a cardinal direction"
      end
    Enum.reverse(additions) ++ current[:history]
  end
end

history = PathFinder.run(File.read!("../path.txt"))
IO.inspect(history)
PathFinder.total_distance(history) |> IO.inspect
