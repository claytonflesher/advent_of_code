class TriangleCounter
  DEFAULT_CANDIDATES = File.read("../triangles.txt")
                       .split("\n")
                       .map { |line| line.split(" ").map { |s| s.to_i } }

  def initialize(candidates = DEFAULT_CANDIDATES)
    @candidates = candidates
  end

  attr_reader :candidates

  def normal_count
    @normal_count ||= candidates.count do |group|
      group.permutation.all? { |arr| arr[0] + arr[1] > arr[2] }
    end
  end

  def vertical_count
    @vertical_count ||= candidates.each_slice(3).reduce(0) do |acc, trio|
      section_count = (0..2).count do |i|
        trio
          .map { |x| x[i] }
          .permutation.all? { |arr| arr[0] + arr[1] > arr[2] }
      end
      acc + section_count
    end
  end
end
