def changeDirectory(currentPath, command):
    # print(f"changeDirectory - command: {command}")
    if command == '/':
        # print(f"1 - changeDirectory ({command}) - from {currentPath} to /")
        return '/'
    elif command == '..':
        index = currentPath.rfind('/', 0, len(currentPath)-1)
        newPath = currentPath[0:index+1]
        # print(f"2 - changeDirectory ({command}) - from {currentPath} to {newPath}")
        return newPath
    else:
        newPath = f'{currentPath}{command}/'
        # print(f"3 - changeDirectory ({command}) - from {currentPath} to {newPath}")
        return newPath
