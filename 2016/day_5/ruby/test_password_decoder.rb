require "minitest/autorun"
require "./password_decoder.rb"

class TestPasswordDecoder < Minitest::Test
  def setup
    @decoder = PasswordDecoder.new("abc")
  end

  def test_has_input
    assert_equal("abc", @decoder.input)
  end

  def test_decodes_simple_password
    assert_equal("18f47a30", @decoder.decode_simple)
  end

  def test_decodes_long_simple_password
    long_example = PasswordDecoder.new("ugkcyxxp")
    assert_equal("d4cd2ee1", long_example.decode_simple)
  end

  def test_decodes_complex_password
    assert_equal("05ace8e3", @decoder.decode_complex)
  end

  def test_decodes_complex_long
    long_example = PasswordDecoder.new("ugkcyxxp")
    assert_equal("f2c730e5", long_example.decode_complex)
  end
end
