require          "minitest/autorun"
require_relative "./home_deliver_counter.rb"

class TestHomeDeliveryCounter < Minitest::Test
  def setup
    @counter = HomeDeliveryCounter.new("^><v")
  end

  def test_has_movements
    assert_equal(["^", ">", "<", "v"], @counter.movements)
  end

  def test_records_route_traveled
    assert_equal(
      [{x: 0, y: 0}, {x: 0, y: 1},
       {x: 1, y: 1}, {x: 0, y: 1},
       {x: 0, y: 0}], @counter.route_traveled)
  end

  def test_counts_number_of_homes_visited
    assert_equal(3, @counter.unique_visits)
  end

  def test_long_count
    movements = File.read("./movements.txt").chomp
    long_counter = HomeDeliveryCounter.new(movements)
    assert_equal(2081, long_counter.unique_visits)
  end

  def test_records_route_pair_traveled
    assert_equal(
      [{:santa=>{:x=>0, :y=>0}, :robot=>{:x=>0, :y=>0}},
       {:santa=>{:x=>0, :y=>1}, :robot=>{:x=>0, :y=>0}},
       {:santa=>{:x=>0, :y=>1}, :robot=>{:x=>1, :y=>0}},
       {:santa=>{:x=>-1, :y=>1}, :robot=>{:x=>1, :y=>0}},
       {:santa=>{:x=>-1, :y=>1}, :robot=>{:x=>1, :y=>-1}}],
      @counter.robot_and_santa_traveled
    )
  end

  def test_counts_number_of_homes_pair_visited
    assert_equal(5, @counter.unique_pair_visits)
  end

  def test_long_pair_count
    movements = File.read("./movements.txt").chomp
    long_counter = HomeDeliveryCounter.new(movements)
    assert_equal(0, long_counter.unique_pair_visits)
  end
end
