class DancingQueen
  def initialize(list)
    @list           = list.split("\n")
    @separated_ip7_list = separate_ip7
    @separated_ssl_list = separate_ssl
  end

  attr_reader :list, :separated_ip7_list, :separated_ssl_list

  def ip7?(addr)
    inner       = /\w+\[\w*(\w)(\w)\2\1\w*\]\w+/.match(addr)
    outer_left  = /\w*(\w)(\w)\2\1\w*\[/.match(addr)
    outer_right = /\]\w*(\w)(\w)\2\1\w*/.match(addr)
    if inner && inner[1] != inner[2]
      false
    elsif outer_left && outer_left[1] != outer_left[2]
      true
    elsif outer_right && outer_right[1] != outer_right[2]
      true
    else
      false
    end
  end

  def ssl?(addr)
    right = /\w+\[\w*(\w)(\w)\1\w*\]\w*\2\1\2\w*/.match(addr)
    left  = /\w*(\w)(\w)\1\w*\[\w*\2\1\2\w*\]\w+/.match(addr)
    right || left ? true : false
  end

  def valid_ip7_list
    separated_ip7_list[:valid]
  end

  def invalid_ip7_list
    separated_ip7_list[:invalid]
  end

  def valid_ip7_count
    separated_ip7_list[:valid].length
  end

  def valid_ssl_list
    separated_ssl_list[:valid]
  end

  def invalid_ssl_list
    separated_ssl_list[:invalid]
  end

  def valid_ssl_count
    separated_ssl_list[:valid].length
  end

  private

  def separate_ip7
    list.reduce({valid: [], invalid: []}) do |memo, addr|
      ip7?(addr) ? memo[:valid] << addr : memo[:invalid] << addr
      memo
    end
  end

  def separate_ssl
    list.reduce({valid: [], invalid: []}) do |memo, addr|
      ssl?(addr) ? memo[:valid] << addr : memo[:invalid] << addr
      memo
    end
  end
end

d = DancingQueen.new(File.read("../ip_addresses.txt"))
p d.valid_ssl_list.length
p d.invalid_ssl_list.length
