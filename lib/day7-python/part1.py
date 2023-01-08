import os
import commandProcessor

def getLineData(filename):
    with open(filename) as f:
        return f.readlines()

class File:
    def __init__(self, name, size):
        self.name = name
        self.size = size

class Directory:
    def __init__(self, path):
        self.path = path
        self.files = []
        self.subDirectories = []
        self.size = 0
        self.totalSize = 0

    def getSubDirectoryTotalSize(self, directoryMap):
        totalSize = 0
        for subDirectoryPath in self.subDirectories:
            subDirectory = directoryMap[subDirectoryPath]
            totalSize = totalSize + subDirectory.size
            totalSize = totalSize + subDirectory.getSubDirectoryTotalSize(directoryMap)
        return totalSize

def buildDirectoryMap():
    currentPath = "/"
    currentDirectory = None
    directoryMap = dict()
    projectDirectory = os.path.dirname(os.path.realpath(__file__))
    for rawline in getLineData(f'{projectDirectory}/input.data'):
        # print(f"reading: {rawline}")
        rawLineChunks = [line.strip() for line in rawline.split(' ')]
        if rawLineChunks[0] == '$':
            if rawLineChunks[1] == 'cd':
                currentPath = commandProcessor.changeDirectory(currentPath=currentPath, command=rawLineChunks[2])
            elif rawLineChunks[1] == 'ls':
                currentDirectory = Directory(currentPath)
                directoryMap[currentPath] = currentDirectory
        else:
            if rawLineChunks[0] == 'dir':
                currentDirectory.subDirectories.append(f'{currentPath}{rawLineChunks[1]}/')
            else:
                newFile = File(name=rawLineChunks[1], size=int(rawLineChunks[0]))
                currentDirectory.files.append(newFile)
                currentDirectory.size = currentDirectory.size + int(rawLineChunks[0])
    return directoryMap


directoryMap = buildDirectoryMap()
totalSizeOfDirectorysOfAtMostOneHundredThousand = 0
for directoryPath, directory in directoryMap.items():
    # print(f'Directory: "{directoryPath}", size: {directory.size}')

    subDirectoryTotalSize = directory.getSubDirectoryTotalSize(directoryMap)
    directory.totalSize = directory.size + subDirectoryTotalSize
    # print(f'Total size of sub directories: {subDirectoryTotalSize}, Total size overall of directory: {directory.totalSize}')
    print(f'Directory: "{directoryPath}", size: {directory.size}, total size: {directory.totalSize}')
    if directory.totalSize <= 100_000:
        totalSizeOfDirectorysOfAtMostOneHundredThousand = totalSizeOfDirectorysOfAtMostOneHundredThousand + directory.totalSize
print(f'Sum of all of the directories with a total size of at most 100,000: {totalSizeOfDirectorysOfAtMostOneHundredThousand}')