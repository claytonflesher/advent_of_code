require_relative './grids.rb'
require_relative './limits.rb'

class Keypad
  def initialize(movements)
    @movements = movements
  end

  attr_reader :movements

  def calculate_square(start: {x: 1, y: 1})
    calculate(shape: :square, start: start)
  end

  def calculate_rotated(start: {x: 0, y: 2})
    calculate(shape: :rotated, start: start)
  end

  private

  def calculate(shape:, start:)
    start_location = start
    entries = movements.map do |string|
      entry = move(string, start_location, shape)
      start_location = entry
      entry
    end
    entries.map { |entry| GRIDS[shape][entry[:y]][entry[:x]]}.join
  end

  def move(string, start_location, shape)
    string.chars.reduce(start_location) do |memo, direction|
      case direction
      when 'U'
        LIMITS[shape]['U'].include?(memo) ? memo : {x: memo[:x], y: memo[:y] - 1}
      when 'D'
        LIMITS[shape]['D'].include?(memo) ? memo : {x: memo[:x], y: memo[:y] + 1}
      when 'L'
        LIMITS[shape]['L'].include?(memo) ? memo : {x: memo[:x] - 1, y: memo[:y]}
      when 'R'
        LIMITS[shape]['R'].include?(memo) ? memo : {x: memo[:x] + 1, y: memo[:y]}
      end
    end
  end
end
