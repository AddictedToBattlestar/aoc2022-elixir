defmodule Day2Part2 do
  def getTotalScore() do
    lineData = getLineData()
    totalScore = calculateTotalScore(lineData)
    "The total score is: #{totalScore}"
  end

  defp getLineData() do
    {:ok, contents} = File.read("input.data")
    contents |> String.split("\n")
  end

  defp calculateTotalScore(lineData) do
    Enum.reduce(lineData, 0, fn (line, accumulator) ->
      [left | [right | _]] = line |> String.split(" ")
      {_, theirPlay} = mapTheirPlayInput(left)
      {_, desiredResult} = mapDesiredResult(right)
      {_, ourPlay} = getOurPlay(theirPlay, desiredResult)
      {_, score} = calculateScore(theirPlay, ourPlay)
      accumulator + score
    end)
  end

  def mapTheirPlayInput(input) when input == "A", do: {:ok, :rock}
  def mapTheirPlayInput(input) when input == "B", do: {:ok, :paper}
  def mapTheirPlayInput(input) when input == "C", do: {:ok, :scissors}
  def mapTheirPlayInput(invalidInput), do: {:error, "mapTheirPlayInput, invalid input #{invalidInput}"}

  def mapDesiredResult(input) when input == "X", do: {:ok, :lose}
  def mapDesiredResult(input) when input == "Y", do: {:ok, :tie}
  def mapDesiredResult(input) when input == "Z", do: {:ok, :win}
  def mapDesiredResult(invalidInput), do: {:error, "mapDesiredResult, invalid input #{invalidInput}"}

  def getOurPlay(theirPlay, desiredResult) when theirPlay == :rock and desiredResult == :lose,      do: {:ok, :scissors}
  def getOurPlay(theirPlay, desiredResult) when theirPlay == :rock and desiredResult == :tie,       do: {:ok, :rock}
  def getOurPlay(theirPlay, desiredResult) when theirPlay == :rock and desiredResult == :win,       do: {:ok, :paper}
  def getOurPlay(theirPlay, desiredResult) when theirPlay == :paper and desiredResult == :lose,     do: {:ok, :rock}
  def getOurPlay(theirPlay, desiredResult) when theirPlay == :paper and desiredResult == :tie,      do: {:ok, :paper}
  def getOurPlay(theirPlay, desiredResult) when theirPlay == :paper and desiredResult == :win,      do: {:ok, :scissors}
  def getOurPlay(theirPlay, desiredResult) when theirPlay == :scissors and desiredResult == :lose,  do: {:ok, :paper}
  def getOurPlay(theirPlay, desiredResult) when theirPlay == :scissors and desiredResult == :tie,   do: {:ok, :scissors}
  def getOurPlay(theirPlay, desiredResult) when theirPlay == :scissors and desiredResult == :win,   do: {:ok, :rock}
  def getOurPlay(invalidtheirPlay, invalidDesiredResult), do: {:error, "getOurPlay - invalid input, their play: #{invalidtheirPlay}, desired result: #{invalidDesiredResult}"}

  def calculateScore(theirPlay, ourPlay) when theirPlay == :rock and ourPlay == :rock,              do: {:ok, 3+1}
  def calculateScore(theirPlay, ourPlay) when theirPlay == :rock and ourPlay == :paper,             do: {:ok, 6+2}
  def calculateScore(theirPlay, ourPlay) when theirPlay == :rock and ourPlay == :scissors,          do: {:ok, 0+3}
  def calculateScore(theirPlay, ourPlay) when theirPlay == :paper and ourPlay == :rock,             do: {:ok, 0+1}
  def calculateScore(theirPlay, ourPlay) when theirPlay == :paper and ourPlay == :paper,            do: {:ok, 3+2}
  def calculateScore(theirPlay, ourPlay) when theirPlay == :paper and ourPlay == :scissors,         do: {:ok, 6+3}
  def calculateScore(theirPlay, ourPlay) when theirPlay == :scissors and ourPlay == :rock,          do: {:ok, 6+1}
  def calculateScore(theirPlay, ourPlay) when theirPlay == :scissors and ourPlay == :paper,         do: {:ok, 0+2}
  def calculateScore(theirPlay, ourPlay) when theirPlay == :scissors and ourPlay == :scissors,      do: {:ok, 3+3}
  def calculateScore(invalidtheirPlay, invalidDesiredResult), do: {:error, "calculateScore - invalid input, their play: #{invalidtheirPlay}, desired result: #{invalidDesiredResult}"}
end
