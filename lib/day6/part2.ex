defmodule Day6.Part2 do
  def findStartOfPacketMarkerIndexFromFile() do
    {:ok, datastreamBuffer} = File.read("input.data")
    findStartOfPacketMarkerIndex(datastreamBuffer)
  end

  def findStartOfPacketMarkerIndex(datastreamBuffer) do
    dataStreamManager = initializeDataStreamMap(datastreamBuffer)
    Enum.reduce_while(dataStreamManager.datastreamRemainder, dataStreamManager, fn(dataStreamCharacter, accumulator) ->
      if isCharacterAlreadyPresent(dataStreamCharacter, accumulator.previousCharacters) do
        [_ | remainder] = accumulator.datastreamRemainder
        [_ | previousCharacters] = accumulator.previousCharacters
        {:cont, %{
          previousCharacters: previousCharacters ++ [dataStreamCharacter],
          currentIndex: accumulator.currentIndex + 1,
          datastreamRemainder: remainder
        }}
      else
        IO.puts("the packet marker has been identified as \"#{List.to_string(accumulator.previousCharacters)}#{dataStreamCharacter}\" at index #{accumulator.currentIndex}")
        {:halt, accumulator.currentIndex}
      end
    end)
  end

  def isCharacterAlreadyPresent(dataStreamCharacter, previousCharacters) do
    characterMap = %{} |> Map.put(dataStreamCharacter, 1)

    result = Enum.reduce_while(previousCharacters, %{characterMap: characterMap, isAlreadyPresent: false}, fn(character, accumulator) ->
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
    Enum.reduce(1..13, %{previousCharacters: [], datastreamRemainder: datastreamListing}, fn(i, accumulator) ->
      [character | datastreamRemainder] = accumulator.datastreamRemainder
      %{
        previousCharacters: accumulator.previousCharacters ++ [character],
        datastreamRemainder: datastreamRemainder,
        currentIndex: i+1,
      }
    end)
  end
end
