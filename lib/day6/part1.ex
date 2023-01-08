defmodule Day6.Part1 do
  def findStartOfPacketMarkerIndexFromFile() do
    {:ok, datastreamBuffer} = File.read("input.data")
    findStartOfPacketMarkerIndex(datastreamBuffer)
  end

  def findStartOfPacketMarkerIndex(datastreamBuffer) do
    dataStreamManager = initializeDataStreamMap(datastreamBuffer)
    Enum.reduce_while(dataStreamManager.datastreamRemainder, dataStreamManager, fn(dataStreamCharacter, accumulator) ->
      if isCharacterAlreadyPresent(dataStreamCharacter, accumulator.lastThree) do
        [_ | remainder] = accumulator.datastreamRemainder
        [_ | lastTwo] = accumulator.lastThree
        {:cont, %{
          lastThree: lastTwo ++ [dataStreamCharacter],
          currentIndex: accumulator.currentIndex + 1,
          datastreamRemainder: remainder
        }}
      else
        IO.puts("the packet marker has been identified as \"#{List.to_string(accumulator.lastThree)}#{dataStreamCharacter}\" at index #{accumulator.currentIndex}")
        {:halt, accumulator.currentIndex}
      end
    end)
  end

  def isCharacterAlreadyPresent(dataStreamCharacter, lastThreeCharacters) do
    characterMap = %{} |> Map.put(dataStreamCharacter, 1)

    result = Enum.reduce_while(lastThreeCharacters, %{characterMap: characterMap, isAlreadyPresent: false}, fn(character, accumulator) ->
      unless Map.has_key?(accumulator.characterMap, character) do
        {:cont, %{characterMap: Map.put(accumulator.characterMap, character, 1), isAlreadyPresent: false}}
      else
        {:halt, %{characterMap: Map.put(accumulator.characterMap, character, 1), isAlreadyPresent: true}}
      end
    end)
    result.isAlreadyPresent
  end

  def initializeDataStreamMap(datastreamBuffer) do
    datastreamListing = String.graphemes(datastreamBuffer)
    [firstCharacter | [secondCharacter | [thirdCharacter | datastreamListing]]] = datastreamListing
    %{
      lastThree: [firstCharacter, secondCharacter, thirdCharacter],
      currentIndex: 4,
      datastreamRemainder: datastreamListing
    }
  end
end
