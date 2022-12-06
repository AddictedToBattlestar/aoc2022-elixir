{:ok, contents} = File.read("input.data")
lineData = contents |> String.split("\n")
result = Enum.reduce(lineData, %{totalCalories: 0, highestCalories: 0}, fn (line, accumulator) ->
  if String.length(line) > 0 do
    {calories, _} = Integer.parse(line)
    totalCalories = accumulator.totalCalories + calories
    if totalCalories > accumulator.highestCalories do
      %{totalCalories: totalCalories, highestCalories: totalCalories}
    else
      %{totalCalories: totalCalories, highestCalories: accumulator.highestCalories}
    end
  else
    %{totalCalories: 0, highestCalories: accumulator.highestCalories}
  end
end)

IO.puts(result.highestCalories)
