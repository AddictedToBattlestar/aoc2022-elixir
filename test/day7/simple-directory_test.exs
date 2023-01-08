defmodule Day7.SimpleDirectoryTest do
  use ExUnit.Case

  test "can setup a directory" do
    subject = Day7.SimpleDirectory.new("fake-directory")
      |> Day7.SimpleDirectory.addFile(10, "fake-file.txt")

    assert subject.path == "fake-directory"
    [fakeFile | remainingFiles] = subject.files
    assert fakeFile.fileName == "fake-file.txt"
    assert fakeFile.fileSize == 10
    assert remainingFiles == []
  end

  test "can add another file" do
    subject = Day7.SimpleDirectory.new("fake-directory")
    |> Day7.SimpleDirectory.addFile(10, "fake-file.txt")
    |> Day7.SimpleDirectory.addFile(100, "fake-file2.txt")

    assert subject.path == "fake-directory"
    [fakeFile | remainingFiles] = subject.files
    assert fakeFile.fileName == "fake-file2.txt"
    assert fakeFile.fileSize == 100

    [fakeFile | remainingFiles] = remainingFiles
    assert fakeFile.fileName == "fake-file.txt"
    assert fakeFile.fileSize == 10

    assert remainingFiles == []
  end
end
