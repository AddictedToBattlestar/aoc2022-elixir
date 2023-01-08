defmodule Day4.Part1 do
  def getCountOfOverlappingPairs() do
    lineData = getLineData()
    calculateCountOfOverlappingPairs(lineData)
  end

  defp getLineData() do
    {:ok, contents} = File.read("input.data")
    contents |> String.split("\n")
  end

  defp calculateCountOfOverlappingPairs(lineData) do
    Enum.reduce(lineData, 0, fn (line, accumulator) ->
      [range1String | [range2String | _]] = line |> String.split(",")
      if isCompletelyOverlapping?(range1String, range2String) do
        IO.puts("range1: #{range1String}, range2: #{range2String}, isCompletelyOverlapping?: true")
        accumulator + 1
      else
        # IO.puts("range1: #{range1String}, range2: #{range2String}, isCompletelyOverlapping?: false")
        accumulator
      end
    end)
  end

  def isCompletelyOverlapping?(range1String, range2String) do
    range1 = getRangeParts(range1String)
    range2 = getRangeParts(range2String)
    areRangesCompletelyOverlapping?(range1, range2)
  end

  def getRangeParts(range) do
    [rangeStartString | [rangeEndString | _]] = range |> String.split("-")
    rangeStart = String.to_integer(rangeStartString)
    rangeEnd = String.to_integer(rangeEndString)
    %{start: rangeStart, end: rangeEnd}
  end

  def areRangesCompletelyOverlapping?(range1, range2) do
    (range1.start <= range2.start && range2.end <= range1.end) ||
    (range2.start <= range1.start && range1.end <= range2.end)
  end
end
