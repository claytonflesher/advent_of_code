require "minitest/autorun"
require_relative "./nice_list.rb"

class TestNiceList < Minitest::Test
  def setup
    @nice_list = NiceList.new("ugknbfddgicrmopn\naaa\njchzalrnumimnmhp\n"<<
                              "haegwjzuvuyypxyu\ndvsqwmarrgswjxmb")
  end

  def test_has_full_list
    assert_equal(
      ["ugknbfddgicrmopn", "aaa", "jchzalrnumimnmhp", "haegwjzuvuyypxyu",
       "dvsqwmarrgswjxmb"], @nice_list.full_list
    )
  end

  def test_has_split_lists
    assert_equal(
      {nice: ["ugknbfddgicrmopn", "aaa"],
       naughty: ["jchzalrnumimnmhp", "haegwjzuvuyypxyu", "dvsqwmarrgswjxmb"]},
      @nice_list.split_lists)
  end

  def test_nice?
    assert(@nice_list.nice?("aaa"))
    refute(@nice_list.nice?("jchzalrnumimnmhp"))
  end

  def test_has_nice_list
    assert_equal(["ugknbfddgicrmopn", "aaa"], @nice_list.nice_list)
  end

  def test_has_naughty_list
    assert_equal(["jchzalrnumimnmhp", "haegwjzuvuyypxyu", "dvsqwmarrgswjxmb"],
                 @nice_list.naughty_list)
  end

  def test_finds_all_nice
    long_list = NiceList.new(File.read("./children.txt"))
    nice_list = NiceList.new(File.read("./nice_list.txt"))
    assert_equal(long_list.nice_list, nice_list.nice_list)
  end

  def test_finds_all_naughty
    long_list = NiceList.new(File.read("./children.txt"))
    naughty_list = NiceList.new(File.read("./naughty_list.txt"))
    assert_equal(naughty_list.naughty_list, long_list.naughty_list)
  end

  def test_has_nice_count
    long_list = NiceList.new(File.read("./children.txt"))
    assert_equal(258, long_list.nice_count)
  end

  def test_has_naughty_count
    long_list = NiceList.new(File.read("./children.txt"))
    assert_equal(742, long_list.naughty_count)
  end
end
