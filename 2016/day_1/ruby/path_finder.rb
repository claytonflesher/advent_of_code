class PathFinder
  def initialize(initial_path)
    @final_destination = walk(initial_path)
    p @final_destination[:history].last
  end

  attr_reader :final_destination

  def total_distance
    final_destination[:x].abs + final_destination[:y].abs
  end

  def first_repeat
    final_destination[:history].select do |x|
      final_destination[:history].count(x) > 1
    end.first
  end

  def first_repeat_distance
    first_repeat[0].abs + first_repeat[1].abs
  end

  private

  def walk(route)
    route.reduce({x: 0, y: 0, direction: 'N', history: [[0,0]]}) do |memo, n|
      new_direction   = turn(memo[:direction], n)
      steps           = step(memo, n[1..-1].to_i, new_direction)
      history         = record(memo, n[1..-1].to_i, new_direction)
      steps[:history] = history
      steps
    end
  end

  def turn(current_direction, destination)
    case current_direction
    when 'N'
      destination[0] == 'R' ? 'E' : 'W'
    when 'S'
      destination[0] == 'R' ? 'W' : 'E'
    when 'E'
      destination[0] == 'R' ? 'S' : 'N'
    when 'W'
      destination[0] == 'R' ? 'N' : 'S'
    end
  end

  def step(start, distance, direction)
    case direction
    when 'N'
      {x: start[:x], y: start[:y] + distance, direction: direction}
    when 'S'
      {x: start[:x], y: start[:y] - distance, direction: direction}
    when 'E'
      {x: start[:x] + distance, y: start[:y], direction: direction}
    when 'W'
      {x: start[:x] - distance, y: start[:y], direction: direction}
    end
  end

  def record(current, distance, new_direction)
    additions =
      case new_direction
      when 'N'
        ((current[:y] + 1).upto(current[:y] + distance)).map   { |y| [current[:x], y] }
      when 'S'
        ((current[:y] - 1).downto(current[:y] - distance)).map { |y| [current[:x], y] }
      when 'E'
        ((current[:x] + 1).upto(current[:x] + distance)).map   { |x| [x, current[:y]] }
      when 'W'
        ((current[:x] - 1).downto(current[:x] - distance)).map { |x| [x, current[:y]] }
      end
    current[:history] + additions
  end
end

initial_path = "R1, R3, L2, L5, L2, L1, R3, L4, R2, L2, L4, R2, L1, R1, L2, R3, L1, L4, R2, L5, R3, R4, L1, R2, L1, R3, L4, R5, L4, L5, R5, L3, R2, L3, L3, R1, R3, L4, R2, R5, L4, R1, L1, L1, R5, L2, R1, L2, R188, L5, L3, R5, R1, L2, L4, R3, R5, L3, R3, R45, L4, R4, R72, R2, R3, L1, R1, L1, L1, R192, L1, L1, L1, L4, R1, L2, L5, L3, R5, L3, R3, L4, L3, R1, R4, L2, R2, R3, L5, R3, L1, R1, R4, L2, L3, R1, R3, L4, L3, L4, L2, L2, R1, R3, L5, L1, R4, R2, L4, L1, R3, R3, R1, L5, L2, R4, R4, R2, R1, R5, R5, L4, L1, R5, R3, R4, R5, R3, L1, L2, L4, R1, R4, R5, L2, L3, R4, L4, R2, L2, L4, L2, R5, R1, R4, R3, R5, L4, L4, L5, L5, R3, R4, L1, L3, R2, L2, R1, L3, L5, R5, R5, R3, L4, L2, R4, R5, R1, R4, L3".split(/, /)

path = PathFinder.new(initial_path)
p path.total_distance
p path.first_repeat
p path.first_repeat_distance
