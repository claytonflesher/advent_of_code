require "minitest/autorun"
require_relative "./key_miner.rb"

class TestKeyMiner < Minitest::Test
  def setup
    @miner = KeyMiner.new("abcdef", "00000")
  end

  def test_has_secret_key
    assert_equal("abcdef", @miner.secret_key)
  end

  def test_finds_coin
    assert_equal(609043, @miner.coin)
  end

  def test_finds_another_coin
    another_miner = KeyMiner.new("ckczppom", "00000")
    assert_equal(117946, another_miner.coin)
  end

  def test_finds_coin_with_different_leading
    six_leading = KeyMiner.new("ckczppom", "000000")
    assert_equal(3938038, six_leading.coin)
  end
end
