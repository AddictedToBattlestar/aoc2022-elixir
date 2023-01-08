defmodule Day3.Part2 do
  def getSumOfPriorities() do
    lineData = getLineData()
    groupedRuckSackData = getGroupedRuckSackData(lineData)
    calculateSumOfPriorities(groupedRuckSackData)
  end

  defp getLineData() do
    {:ok, contents} = File.read("input.data")
    contents |> String.split("\n")
  end

  defp getGroupedRuckSackData(groupedRuckSackData) do
    results = Enum.reduce(groupedRuckSackData, %{groupedRuckSackData: [], currentRuckSackCounter: 1}, fn (line, accumulator) ->
      cond do
        accumulator.currentRuckSackCounter == 1 ->
          %{
            groupedRuckSackData: [
              %{
                firstRuckSack: line
              }
              | accumulator.groupedRuckSackData
            ],
            currentRuckSackCounter: 2
          }
        accumulator.currentRuckSackCounter == 2 ->
          [thisGroupRuckSackData | existingGroupedRuckSackData] = accumulator.groupedRuckSackData
          %{
            groupedRuckSackData: [
              %{
                firstRuckSack: thisGroupRuckSackData.firstRuckSack,
                secondRuckSack: line
              }
              | existingGroupedRuckSackData
            ],
            currentRuckSackCounter: 3
          }
        accumulator.currentRuckSackCounter == 3 ->
          [thisGroupRuckSackData | existingGroupedRuckSackData] = accumulator.groupedRuckSackData
          %{
            groupedRuckSackData: [
              %{
                firstRuckSack: thisGroupRuckSackData.firstRuckSack,
                secondRuckSack: thisGroupRuckSackData.secondRuckSack,
                thirdRuckSack: line
              }
              | existingGroupedRuckSackData
            ],
            currentRuckSackCounter: 1
          }
      end
    end)
    results.groupedRuckSackData
  end

  defp calculateSumOfPriorities(groupedRuckSackData) do
    Enum.reduce(groupedRuckSackData, 0, fn (ruckSackData, accumulator) ->
      IO.puts("ruckSackData - firstRuckSack: \"#{ruckSackData.firstRuckSack}\", secondRuckSack: \"#{ruckSackData.secondRuckSack}\", thirdRuckSack: \"#{ruckSackData.thirdRuckSack}\"")
      groupBadge = findBadgeFromRuckSackData(ruckSackData)
      IO.puts("groupBadge: #{groupBadge}")
      priority = getPriority(groupBadge)
      accumulator + priority
    end)
  end

  defp findBadgeFromRuckSackData(ruckSackData) do
    Enum.find(String.graphemes(ruckSackData.firstRuckSack), fn(item) ->
      String.contains?(ruckSackData.secondRuckSack, item) &&
        String.contains?(ruckSackData.thirdRuckSack, item)
    end)
  end

  def getPriority(character) do
    priorityList = String.graphemes("0abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    Enum.find_index(priorityList, fn(item) -> item == character end)
  end
end
