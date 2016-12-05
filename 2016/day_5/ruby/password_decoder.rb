require 'digest'

class PasswordDecoder
  def initialize(input)
    @input   = input
    @integer = 0
  end

  attr_reader :input, :result

  def decode_simple
    @simple_result ||= find_simple_results.map { |x| x[5] }.join
  end

  def decode_complex
    @complex_result ||= build_complex(find_complex_results)
  end

  private

  def find_simple_results
    result = []
    8.times do
      find_next_digest
      result << Digest::MD5.hexdigest(input + @integer.to_s)
      @integer += 1
    end
    result
  end

  def find_complex_results
    result  = []
    indexes = []
    until result.length == 8
      find_next_digest
      candidate = Digest::MD5.hexdigest(input + @integer.to_s)
      if !indexes.include?(candidate[5]) && valid_complex?(candidate)
        indexes << candidate[5]
        result << candidate
      end
      @integer += 1
    end
    result
  end

  def find_next_digest
    until Digest::MD5.hexdigest(input + @integer.to_s)[0..4] == "00000"
      @integer += 1
    end
  end

  def build_complex(results)
    results.reduce([]) do |memo, string|
      memo[string[5].to_i] = string[6]
      memo
    end.join
  end

  def valid_complex?(candidate)
    candidate[5] =~ /[0-7]/
  end
end
