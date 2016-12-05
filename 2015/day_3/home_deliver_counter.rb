class HomeDeliveryCounter
  def initialize(movements)
    @movements                = movements.chars
    @route_traveled           = visited
    @robot_and_santa_traveled = pair_visited
  end

  attr_reader :movements, :route_traveled, :robot_and_santa_traveled

  def unique_visits
    @visits_count ||= route_traveled.uniq.length
  end

  def unique_pair_visits
    @pair_visits_count ||= robot_and_santa_traveled.reduce([]) do |memo, house|
      memo << house[:santa]
      memo << house[:robot]
    end.uniq.length
  end

  private

  def visited
    start = {x: 0, y: 0}
    movements.reduce({santa: start, history: [start]}) do |memo, direction|
      new_current = get_new_current(
        memo: memo, direction: direction, user: :santa
      )
      {santa: new_current, history: memo[:history] << new_current}
    end[:history]
  end

  def pair_visited
    start = {x: 0, y: 0}
    starting_data_object = {
      santa: start,
      robot: start,
      santa_turn: true,
      history: [{santa: start, robot: start}]
    }
    movements.reduce(starting_data_object) do |memo, direction|
      if memo[:santa_turn]
        increment_santa(memo, direction)
      else
        increment_robot(memo, direction)
      end
    end[:history]
  end

  def get_new_current(memo:, direction:, user:)
    case direction
    when "^"; {x: memo[user][:x], y: memo[user][:y] + 1}
    when "v"; {x: memo[user][:x], y: memo[user][:y] - 1}
    when ">"; {x: memo[user][:x] + 1, y: memo[user][:y]}
    when "<"; {x: memo[user][:x] - 1, y: memo[user][:y]}
    else; raise "Bad input."
    end
  end

  def increment_santa(memo, direction)
    new_current = get_new_current(memo: memo, direction: direction, user: :santa)
    {santa: new_current,
     robot: memo[:robot],
     santa_turn: false,
     history: memo[:history] << {santa: new_current, robot: memo[:robot]}
    }
  end

  def increment_robot(memo, direction)
    new_current = get_new_current(memo: memo, direction: direction, user: :robot)
    {santa: memo[:santa],
     robot: new_current,
     santa_turn: true,
     history: memo[:history] << {santa: memo[:santa], robot: new_current}
    }
  end
end
