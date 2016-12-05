require          'minitest/autorun'
require_relative './room_finder.rb'

class TestRoomFinder < Minitest::Test
  def setup
    @finder = RoomFinder.new(
      "aaaaa-bbb-z-y-x-123[abxyz]\na-b-c-d-e-f-g-h-987-[abcde]\nnot-a-real-"<<
      "room-404-[oarel]\ntotally-real-room-200[decoy]")
  end

  def test_has_formatted_rooms
    assert_equal(
      [{name: ["aaaaa", "bbb", "z", "y", "x"],          id: "123", checksum: "abxyz"},
       {name: ["a", "b", "c", "d", "e", "f", "g", "h"], id: "987", checksum: "abcde"},
       {name: ["not", "a", "real", "room"],             id: "404", checksum: "oarel"},
       {name: ["totally", "real", "room"],              id: "200", checksum: "decoy"}],
      @finder.rooms
    )
  end

  def test_has_valid_rooms
    assert_equal(
      [{name: ["aaaaa", "bbb", "z", "y", "x"],          id: "123", checksum: "abxyz"},
       {name: ["a", "b", "c", "d", "e", "f", "g", "h"], id: "987", checksum: "abcde"},
       {name: ["not", "a", "real", "room"],             id: "404", checksum: "oarel"}],
      @finder.valid_rooms
    )
  end

  def test_sector_ids
    assert_equal(1514, @finder.sector_ids)
  end

  def test_long_example
    file = File.read("../rooms.txt")
    long_find = RoomFinder.new(file)
    assert_equal(361724, long_find.sector_ids)
  end

  def test_finds_northpole
    file = File.read("../rooms.txt")
    long_find = RoomFinder.new(file)
    assert_equal("482", long_find.find_room_by_name("north")[:id])
  end
end
