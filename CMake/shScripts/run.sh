#!/bin/bash
originalDir="$(pwd)"
bashDir="$(dirname -- $BASH_SOURCE)"
cd "${bashDir}/.."

cmakePath="./SomeFile.txt"

projectInfo=$(grep -o "project(.*" $cmakePath)

projectName=$(grep -oP 'project\(\K.*?(?= )' <<< "$projectInfo")

# TODO/QOL: Search the build directory if $projectName.exe exists and prompt user to take action if it does not

# Note: If the executable's name is different from the project name, replace $projectName with the proper name

#Note: might need to remove /Debug/ as it seems to be there only on windows
./build/Debug/"$projectName"

cd "$originalDir"