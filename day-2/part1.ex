defmodule Day2Part1 do
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
      [leftInput | [rightInput | _]] = line |> String.split(" ")
      {_, left} = mapInput(leftInput)
      {_, right} = mapInput(rightInput)
      {_, score} = calculateScore(left, right)
      accumulator + score
    end)
  end

  def mapInput(input) when input == "A" or input == "X", do: {:ok, :rock}
  def mapInput(input) when input == "B" or input == "Y", do: {:ok, :paper}
  def mapInput(input) when input == "C" or input == "Z", do: {:ok, :scissors}
  def mapInput(invalidInput), do: {:error, "invalid input #{invalidInput}"}

  def calculateScore(left, right) when left == :rock and right == :rock,          do: {:ok, 3+1}
  def calculateScore(left, right) when left == :rock and right == :paper,         do: {:ok, 6+2}
  def calculateScore(left, right) when left == :rock and right == :scissors,      do: {:ok, 0+3}
  def calculateScore(left, right) when left == :paper and right == :rock,         do: {:ok, 0+1}
  def calculateScore(left, right) when left == :paper and right == :paper,        do: {:ok, 3+2}
  def calculateScore(left, right) when left == :paper and right == :scissors,     do: {:ok, 6+3}
  def calculateScore(left, right) when left == :scissors and right == :rock,      do: {:ok, 6+1}
  def calculateScore(left, right) when left == :scissors and right == :paper,     do: {:ok, 0+2}
  def calculateScore(left, right) when left == :scissors and right == :scissors,  do: {:ok, 3+3}
  def calculateScore(invalidLeft, invalidRight), do: {:error, "invalid input: left: #{invalidLeft}, right: #{invalidRight}"}
end
