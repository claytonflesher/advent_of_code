require "digest"

class KeyMiner
  def initialize(secret_key, leading)
    @secret_key = secret_key
    @coin   ||= find_coin(leading)
  end

  attr_reader :secret_key, :coin

  private

  def find_coin(leading)
    integer = 0
    until Digest::MD5.hexdigest(secret_key + integer.to_s)[0..(leading.length - 1)] == leading
      integer += 1
    end
    integer
  end
end
