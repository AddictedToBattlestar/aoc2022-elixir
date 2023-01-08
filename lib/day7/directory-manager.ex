defmodule DirectoryManager do
  def new() do
    %{}
  end

  def addDirectory(directoryManager, newDirectory) do
    Map.put(directoryManager, newDirectory.path, newDirectory)
  end

  def getDirectory(directoryManager, directoryPath) do
    Map.get(directoryManager, directoryPath)
  end
end
