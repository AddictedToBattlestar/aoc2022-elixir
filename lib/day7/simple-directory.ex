defmodule Day7.SimpleDirectory do
  def new(path) do
    %{
      path: path,
      files: [],
      totalDirectorySize: 0
    }
  end

  def addFile(directory, fileSize, fileName) do
    %{
      path: directory.path,
      files: [%{fileSize: fileSize, fileName: fileName} | directory.files],
      totalDirectorySize: directory.totalDirectorySize + fileSize
    }
  end
end
