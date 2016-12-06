class SignalDecoder
  def initialize(signal)
    @signal = signal.split("\n")
  end

  attr_reader :signal

  def decoded_signal_most_common
    sorted_chars.reduce([]) do |memo, list|
      memo << list.each_with_object(Hash.new(0)) do |char, hash|
        hash[char] += 1
      end.sort_by { |k, v| -v }.first[0]
    end.join
  end

  def decoded_signal_least_common
    sorted_chars.reduce([]) do |memo, list|
      memo << list.each_with_object(Hash.new(0)) do |char, hash|
        hash[char] += 1
      end.sort_by { |k, v| v }.first[0]
    end.join
  end

  private

  def sorted_chars
    start = Array.new(@signal.first.length) { [] }
    @signal.reduce(start) do |memo, str|
      str.chars.each_with_index.map { |char, i| memo[i] << char}
    end
  end
end
