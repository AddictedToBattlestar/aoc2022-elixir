defmodule Part1 do
  def getSumOfPriorities() do
    lineData = getLineData()
    calculateSumOfPriorities(lineData)
  end

  defp getLineData() do
    {:ok, contents} = File.read("input.data")
    contents |> String.split("\n")
  end

  defp calculateSumOfPriorities(lineData) do
    Enum.reduce(lineData, 0, fn (line, accumulator) ->
      IO.puts("line: #{line}")
      {container1, container2} = splitRuckSack(line)
      IO.puts("container1: #{container1}")
      IO.puts("container2: #{container2}")
      result = Enum.find(String.graphemes(container1), fn(lineChar) ->
        IO.puts("lineChar: #{lineChar}, container2: #{container2}")
        String.contains?(container2, lineChar)
      end)
      IO.puts("result: #{result}")
      priority = getPriority(result)
      IO.puts("priority: #{priority}")
      accumulator + priority
    end)
  end

  defp splitRuckSack(line) do
    length = String.length(line)
    halfLength = trunc(length/2)
    container1 = String.slice(line, 0, halfLength)
    container2 = String.slice(line, halfLength, length - 1)
    {container1, container2}
  end

  def getPriority(character) do
    priorityList = String.graphemes("0abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    Enum.find_index(priorityList, fn(item) -> item == character end)
  end
end
