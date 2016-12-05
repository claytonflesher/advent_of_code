require 'set'
class RoomFinder
  def initialize(rooms)
    @rooms       = format(rooms)
    @valid_rooms = find_valid_rooms
  end

  attr_reader :valid_rooms, :rooms

  def sector_ids
     valid_rooms.reduce(0) { |memo, room| room[:id].to_i + memo }
  end

  def find_room_by_name(name)
    valid_rooms.find do |room|
      distance = room[:id].to_i % 26
      room[:name].map do |word|
        word.chars.map do |char|
          c = char
          distance.times do
            c = c.next
          end
          c[-1]
        end.join
      end.join(" ").include?(name)
    end
  end

  private

  def format(list)
    lines = list.gsub(/[-\[\]]/, " ").split(" \n").map { |x| x.split(" ") }
    lines.map { |x| {name: x[0..-3], id: x[-2], checksum: x[-1]} }
  end

  def find_valid_rooms
    @rooms.find_all do |room|
      room[:checksum] == room[:name].join.chars.sort.reverse.sort_by do |x|
        room[:name].join.chars.count { |l| l == x }
      end.reverse.to_set.to_a.join[0..4]
    end
  end
end
