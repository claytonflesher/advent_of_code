DEFAULT_BOXES = File.read("./boxes.txt")
                .split("\n")
                .map { |box| box.split("x").map { |x| x.to_i } }

class WrappingPaper
  def initialize(boxes = DEFAULT_BOXES)
    @boxes = boxes.map { |x| {l: x[0], w: x[1], h: x[2]} }
  end

  attr_reader :boxes

  def paper_length
    boxes.reduce(0) do |memo, box|
      a = (box[:l] * box[:w])
      b = (box[:w] * box[:h])
      c = (box[:h] * box[:l])
      [a, b, c].min + [a, b, c].reduce(0) { |m, n| 2 * n + m } + memo
    end
  end

  def ribbon_length
    boxes.reduce(0) do |memo, box|
      around = box.values.min(2).reduce(0) { |m, n| m + n * 2}
      bow    = box.values.reduce(:*)
      memo + around + bow
    end
  end
end
