require "minitest/autorun"
require_relative "./keypad.rb"

class TestKeypad < Minitest::Test
  SHORT = ["UUUDDDUUU", "LLLRRRLLL", "RUDL", "LDUR"]
  LONG  = File.read("../keypad.txt").split("\n")
  def setup
    @keypad = Keypad.new(SHORT)
  end

  def test_that_has_movements
    result = ["UUUDDDUUU", "LLLRRRLLL", "RUDL", "LDUR"]
    assert_equal(result, @keypad.movements)
  end

  def test_that_calculate_square_grid_code_works
    result = '2145'
    assert_equal(result, @keypad.calculate_square)
  end

  def test_square_with_long_series
    long_keypad = Keypad.new(LONG)
    result      = '69642'
    assert_equal(result, long_keypad.calculate_square)
  end

  def test_that_calculate_rotated_square_grid_code_works
    result =  '5556'
    assert_equal(result, @keypad.calculate_rotated)
  end

  def test_rotated_with_long_series
    long_keypad = Keypad.new(LONG)
    result      = '8CB23'
    assert_equal(result, long_keypad.calculate_rotated)
  end
end
