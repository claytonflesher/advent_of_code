GRID = [[1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]]

class Keypad
  def initialize(movements)
    @movements = movements
  end

  attr_reader :movements

  def calculate_code
    entries  = []
    start_location = {x: 1, y: 1}
    movements.each do |string|
      entry = string.chars.reduce(start_location) do |memo, direction|
        case direction
        when 'U'
          memo[:y] == 0 ? memo : {x: memo[:x], y: memo[:y] - 1}
        when 'D'
          memo[:y] == 2 ? memo : {x: memo[:x], y: memo[:y] + 1}
        when 'L'
          memo[:x] == 0 ? memo : {x: memo[:x] - 1, y: memo[:y]}
        when 'R'
          memo[:x] == 2 ? memo : {x: memo[:x] + 1, y: memo[:y]}
        end
      end
      start_location = entry
      entries << entry
    end
    entries.map { |coord| GRID[coord[:y]][coord[:x]] }.join.to_i
  end
end
