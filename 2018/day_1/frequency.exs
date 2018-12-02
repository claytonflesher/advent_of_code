defmodule AdventOfCode.Frequency do
  def calculate_frequency(list) do
    change_frequency(list, 0)
  end

  defp change_frequency([offset | tail], state) do
    new_state = state + String.to_integer(offset)
    change_frequency(tail, new_state)
  end

  defp change_frequency([], state) do
    state
  end
end

{:ok, file} = File.read("input.txt")
file
|> String.split("\n")
|> List.delete_at(-1)
|> AdventOfCode.Frequency.calculate_frequency
|> IO.inspect


