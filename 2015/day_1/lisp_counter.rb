class LispCounter
  def initialize(parens)
    @string = parens
    @groups = parens.chars.group_by { |x| x == '(' }
  end

  def floor
    @groups[true].length - @groups[false].length
  end

  def first_negative
    data_object = { first_neg: nil, basement: false, i: 0, floor: 0 }
    result = @string.chars.reduce(data_object) do |memo, x|
      memo[:basement] ? memo : move_floor(memo, x)
    end
    result[:first_neg]
  end

  def move_floor(data_object, unit)
    if unit == ')'
      new_floor = data_object[:floor] - 1
      first_neg = data_object[:i] + 1 if new_floor.negative?
      basement  = new_floor.negative?
    else
      new_floor = data_object[:floor] + 1
      first_neg = data_object[:first_neg]
      basement  = data_object[:basement]
    end
    {first_neg: first_neg, basement: basement, i: data_object[:i] + 1, floor: new_floor }
  end
end

parens = File.read("lisp_counter.txt")
p LispCounter.new(parens).first_negative
