require "minitest/autorun"
require_relative "./signal_decoder.rb"

class TestSignalDecoder < Minitest::Test
  def setup
    @decoder = SignalDecoder.new("eedadn\ndrvtee\neandsr\nraavrd\natevrs\n"<<
                                 "tsrnev\nsdttsa\nrasrtv\nnssdts\nntnada\n"<<
                                 "svetve\ntesnvt\nvntsnd\nvrdear\ndvrsen\n"<<
                                 "enarar")
  end

  def test_formats_signal
    assert_equal(["eedadn", "drvtee", "eandsr", "raavrd", "atevrs", "tsrnev",
                  "sdttsa", "rasrtv", "nssdts", "ntnada", "svetve", "tesnvt",
                  "vntsnd", "vrdear", "dvrsen", "enarar"],
                 @decoder.signal)
  end

  def test_decoded_signal_most_common
    assert_equal("easter", @decoder.decoded_signal_most_common)
  end

  def test_decodes_long_signal_most_common
    long_signal = SignalDecoder.new(File.read("../signal.txt"))
    assert_equal("tkspfjcc", long_signal.decoded_signal_most_common)
  end

  def test_decoded_signal_least_common
    assert_equal("advent", @decoder.decoded_signal_least_common)
  end

  def test_decodes_long_signal_least_common
    long_signal = SignalDecoder.new(File.read("../signal.txt"))
    assert_equal("xrlmbypn", long_signal.decoded_signal_least_common)
  end
end
