#!/bin/bash
originalDir="$(pwd)"
bashDir="$(dirname -- $BASH_SOURCE)"
cd "${bashDir}/.."

cmakePath="./CMakeLists.txt"

projectInfo=$(grep -o "project(.*" $cmakePath)

projectName=$(grep -oP 'project\(\K.*?(?= )' <<< "$projectInfo")

# TODO/QOL: Search the build directory if $projectName.exe exists and prompt user to take action if it does not

#Note: Change dir before executing, so that termination (via ctrl-c) does not leave the user in an undesirable dir
cd "$originalDir"

# Note: If the executable's name is different from the project name, replace $projectName with the proper name
#Note2: path has to look like  ${bashDir}/../build/Debug/"$projectName" on a windows os
${bashDir}/../build/"$projectName"
#NOTE: Untested!
