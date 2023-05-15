#!/bin/bash

sourceFolderPath="./src"
targetFileFolderPath="./cmake"
outputFileName="sourceList.cmake"
fileContents="target_sources(\${PROJECT_NAME} PRIVATE\n"

cppFiles=$(find "$sourceFolderPath" -type f -name "*.cpp")
cFiles=$(find "$sourceFolderPath" -type f -name "*.c")

sourceFiles="$cFiles"$'\n'"$cppFiles"

# save $IFS
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

for currentFile in $sourceFiles; do
    fileContents+="\t\t\t\t\"$currentFile\"\n"
done

# restore $IFS
IFS=$SAVEIFS

fileContents+="\t\t\t\t)"

mkdir -p $targetFileFolderPath

echo -e $fileContents > $targetFileFolderPath/$outputFileName