require "minitest/autorun"
require "./dancing_queen.rb"

class TestDancingQueen < Minitest::Test
  def setup
    @queen = DancingQueen.new(
      "abba[mnop]qrst\nabcd[bddb]xyyx\naaaa[qwer]tyui\nioxxoj[asdfgh]zxcvbn"
    )
  end

  def test_has_a_formatted_list
    assert_equal(["abba[mnop]qrst", "abcd[bddb]xyyx", "aaaa[qwer]tyui",
                  "ioxxoj[asdfgh]zxcvbn"], @queen.list)
  end

  def test_can_tell_if_string_is_ip7
    assert(@queen.ip7?("abba[mnop]qrst"))
    refute(@queen.ip7?("abcd[bddb]xyyx"))
    refute(@queen.ip7?("aaaa[qwer]tyui"))
    assert(@queen.ip7?("ioxxoj[asdfgh]zxcvbn"))
  end

  def test_separates_into_ip7_and_non_ip7_lists
    assert_equal(
      {valid: ["abba[mnop]qrst", "ioxxoj[asdfgh]zxcvbn"],
       invalid: ["abcd[bddb]xyyx", "aaaa[qwer]tyui"]},
      @queen.separated_ip7_list)
  end

  def test_has_ip7_list
    assert_equal(["abba[mnop]qrst", "ioxxoj[asdfgh]zxcvbn"], @queen.valid_ip7_list)
  end

  def test_has_non_ip7_list
    assert_equal(["abcd[bddb]xyyx", "aaaa[qwer]tyui"], @queen.invalid_ip7_list)
  end

  def test_has_ip7_count
    assert_equal(2, @queen.valid_ip7_count)
  end

  def test_count_long_ip7_list
    long_list = DancingQueen.new(File.read("../ip_addresses.txt"))
    assert_equal(105, long_list.valid_ip7_count)
  end

  def test_can_tell_if_string_is_ssl
    assert(@queen.ssl?("aba[bab]xyz"))
    refute(@queen.ssl?("xyx[xyx]xyz"))
    assert(@queen.ssl?("aaa[kek]eke"))
    assert(@queen.ssl?("zazbz[bzb]cdb"))
  end

  def test_count_long_ssl_list
    long_list = DancingQueen.new(File.read("../ip_addresses.txt"))
    assert_equal(244, long_list.valid_ssl_count)
  end
end
