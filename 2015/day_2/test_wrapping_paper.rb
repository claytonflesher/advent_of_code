require 'minitest/autorun'
require_relative("./wrapping_paper.rb")

SHORT = [[2, 3, 4], [1, 1, 10]]

class TestWrappingPaper < Minitest::Test
  def setup
    @wrapping = WrappingPaper.new(SHORT)
  end

  def test_has_boxes_with_dimensions
    result = [{l: 2, w: 3, h: 4}, {l: 1, w: 1, h: 10}]
    assert_equal(result, @wrapping.boxes)
  end

  def test_accurately_calculates_paper
    assert_equal(101, @wrapping.paper_length)
  end

  def test_long_paper_calculation
    long_wrapping = WrappingPaper.new
    assert_equal(1588178, long_wrapping.paper_length)
  end

  def test_accurately_calculates_ribbon
    assert_equal(48, @wrapping.ribbon_length)
  end

  def test_long_ribbon_calculation
    long_wrapping = WrappingPaper.new
    assert_equal(3783758, long_wrapping.ribbon_length)
  end
end
