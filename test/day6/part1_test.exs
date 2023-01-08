defmodule Day6.Part1Test do
  use ExUnit.Case

  test "it identifies the start of packet marker of 5 in `bvwbjplbgvbhsrlpgdmjqwftvncz`" do
    assert Day6.Part1.findStartOfPacketMarkerIndex("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
  end

  test "it identifies the start of packet marker of 5 in `nppdvjthqldpwncqszvftbrmjlhg`" do
    assert Day6.Part1.findStartOfPacketMarkerIndex("nppdvjthqldpwncqszvftbrmjlhg") == 6
  end

  test "it identifies the start of packet marker of 5 in `nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg`" do
    assert Day6.Part1.findStartOfPacketMarkerIndex("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
  end

  test "it identifies the start of packet marker of 5 in `zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw`" do
    assert Day6.Part1.findStartOfPacketMarkerIndex("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  end
end
