class NiceList
  def initialize(full_list)
    @full_list = full_list.split("\n")
  end

  attr_reader :full_list

  def split_lists
    @split_lists ||= full_list.reduce({nice: [], naughty: []}) do |memo, child|
      nice?(child) ? (memo[:nice] << child) : (memo[:naughty] << child)
      memo
    end
  end

  def nice?(child)
    exclusions = child =~ /(ab|cd|pq|xy)/
    child.gsub(/[^aeiou]/, "").length >= 3 &&
      child =~ /(.)\1+/ &&
      !exclusions
  end

  def nice_list
    split_lists[:nice]
  end

  def naughty_list
    split_lists[:naughty]
  end

  def nice_count
    nice_list.length
  end

  def naughty_count
    naughty_list.length
  end
end
