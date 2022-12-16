defmodule SupplyStackBuilder do
  def new(lineData) do
    [rawHeaderData | rawStackData] = lineData |> Enum.reverse()
    initialStackDataTracker = setupInitialStackDataTracker(rawHeaderData)
    collectStackData(initialStackDataTracker, rawStackData)
  end

  defp setupInitialStackDataTracker(rawHeaderData) do
    lineLength = String.length(rawHeaderData)
    numberOfStacks = lineLength / 4 |> round
    Enum.reduce(1..numberOfStacks, %{}, fn(stackNumber, accumulator) ->
      Map.put(accumulator, stackNumber, [])
    end)
  end

  defp collectStackData(stackDataTracker, rawStackData) do
    Enum.reduce(rawStackData, stackDataTracker, fn(stackDataLine, currentStackDataTracker) ->
      collectStackDataLine(currentStackDataTracker, stackDataLine)
    end)
  end

  defp collectStackDataLine(stackDataTracker, stackDataLine) do
    Enum.reduce(Map.keys(stackDataTracker), stackDataTracker, fn(stackNumber, currentStackDataTracker) ->
      indexPosition = getIndexPositionForCrate(stackNumber)
      crate = stackDataLine |> String.at(indexPosition)
      # IO.puts("stackDataLine: \"#{stackDataLine}\", indexPosition: #{indexPosition}, crate: \"#{crate}\"")
      if (crate != " ") do
        addCrateToStackDataTracker(currentStackDataTracker, stackNumber, crate)
      else
        currentStackDataTracker
      end
    end)
  end

  defp getIndexPositionForCrate(stackNumber) do
    # Crate data is written for each stack 4 characters aparts, starting at the 2nd(3rd zero based) character of the stackDataLine
    stackNumber * 4 - 3
  end

  defp addCrateToStackDataTracker(stackDataTracker, stackNumber, crate) do
    stack = Map.get(stackDataTracker, stackNumber)
    updatedStack = [crate | stack]
    Map.put(stackDataTracker, stackNumber, updatedStack)
  end
end

defmodule SupplyStackProcessor do
  def parseStackChangeMessage(message) do
    wordsInMessage = message |> String.split(" ")
    numberOfCrates = wordsInMessage |> Enum.at(1) |> String.to_integer()
    sourceStackNumber = wordsInMessage |> Enum.at(3) |> String.to_integer()
    targetStackNumber = wordsInMessage |> Enum.at(5) |> String.to_integer()
    %{numberOfCrates: numberOfCrates, sourceStackNumber: sourceStackNumber, targetStackNumber: targetStackNumber}
  end

  def moveCrates(stackDataTracker, %{numberOfCrates: numberOfCrates, sourceStackNumber: sourceStackNumber, targetStackNumber: targetStackNumber}) do
    stack = Map.get(stackDataTracker, sourceStackNumber)
    changes = Enum.reduce(1..numberOfCrates, %{cratesRemoved: [], sourceStack: stack}, fn(_, accumulator) ->
      [crate | remainingStack] = accumulator.sourceStack
      %{cratesRemoved: accumulator.cratesRemoved ++ [crate], sourceStack: remainingStack}
    end)
    targetStack = Map.get(stackDataTracker, targetStackNumber)
    Map.put(stackDataTracker, targetStackNumber, changes.cratesRemoved ++ targetStack) |>
        Map.put(sourceStackNumber, changes.sourceStack)
  end

  def findTopCratesFromStacks(stackDataTracker) do
    Enum.reduce(Map.keys(stackDataTracker), [], fn(stackNumber, topCrates) ->
      [topCrate | _] = Map.get(stackDataTracker, stackNumber)
      [topCrate | topCrates]
    end) |> Enum.reverse() |> List.to_string()
  end
end

defmodule Part2 do
  def processStackChangesAndFindTopCrates() do
    lineData = getLineDataForStackSetup()
    stackDataTracker = SupplyStackBuilder.new(lineData)
    IO.inspect(stackDataTracker)

    messages = getLineDataForStackProcedure()
    resultingStackDataTracker = Enum.reduce(messages, stackDataTracker, fn(message, currentStackDataTracker) ->
      IO.puts(message)
      parsedMessage = SupplyStackProcessor.parseStackChangeMessage(message)
      resultingStackDataTracker = SupplyStackProcessor.moveCrates(currentStackDataTracker, parsedMessage)
      IO.inspect(resultingStackDataTracker)
      resultingStackDataTracker
    end)

    SupplyStackProcessor.findTopCratesFromStacks(resultingStackDataTracker)
  end

  defp getLineDataForStackSetup() do
    {:ok, contents} = File.read("stacks-input.data")
    contents |> String.split("\n")
  end

  defp getLineDataForStackProcedure() do
    {:ok, contents} = File.read("input.data")
    contents |> String.split("\n")
  end
end
