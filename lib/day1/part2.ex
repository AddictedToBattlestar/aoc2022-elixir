defmodule Day1.Part2 do
  def getTop3() do
    lineData = getLineData()
    totalCaloriesArray = getTotalCaloriesArray(lineData)
    sortedTotalCaloriesArray = Enum.sort(totalCaloriesArray, :desc)
    [first | [second | [third | _]]] = sortedTotalCaloriesArray
    IO.puts("first: #{first}, second: #{second}, third #{third}.  Total: #{first + second + third}")
  end

  defp getLineData() do
    {:ok, contents} = File.read("day-1/input.data")
    contents |> String.split("\n")
  end

  defp getTotalCaloriesArray(lineData) do
    accumulator = Enum.reduce(lineData, %{totalCalories: 0, totalCaloriesArray: []}, fn (line, accumulator) ->
      if String.length(line) > 0 do
        {calories, _} = Integer.parse(line)
        totalCalories = accumulator.totalCalories + calories
        %{totalCalories: totalCalories, totalCaloriesArray: accumulator.totalCaloriesArray}
      else
        %{totalCalories: 0, totalCaloriesArray: [accumulator.totalCalories | accumulator.totalCaloriesArray]}
      end
    end)
    [accumulator.totalCalories | accumulator.totalCaloriesArray]
  end
end
