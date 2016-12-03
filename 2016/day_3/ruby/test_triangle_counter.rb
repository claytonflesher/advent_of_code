require 'minitest/autorun'
require_relative './triangle_counter.rb'

class TestTriangleCounter < Minitest::Test
  SHORT = [[2, 3, 4], [2, 2, 3], [1, 1, 10]]

  def setup
    @counter = TriangleCounter.new(SHORT)
  end

  def test_has_candidates
    assert_equal(SHORT, @counter.candidates)
  end

  def test_counts_normal_triangles
    assert_equal(2, @counter.normal_count)
  end

  def test_long_count
    long_counter = TriangleCounter.new
    assert_equal(917, long_counter.normal_count)
  end

  def test_counts_vertical_triangles
    assert_equal(1, @counter.vertical_count)
  end

  def test_long_vertical_count
    long_counter = TriangleCounter.new
    assert_equal(1649, long_counter.vertical_count)
  end
end
