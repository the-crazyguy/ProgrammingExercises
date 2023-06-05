#!/bin/bash

set -o errexit # Stop on error

originalDir="$(pwd)"
bashDir="$(dirname -- $BASH_SOURCE)"
cd "${bashDir}"

openInCode=true

if [[ $# == 0 ]]
    then
    read -p "Project name: " projectName
    read -e -p "Project path: " projectPath
    read -p "Scripts for (Linux = l, Windows = w, Both = b): " scriptType
elif [[ $# > 3 ]]
    then
    echo "$0: Too many arguments"
    exit 1
elif [[ $# == 3 ]]
    then
    projectName="$1"
    projectPath="$2"
    scriptType="$3"
elif [[ $# == 4 ]]
    then
    projectName="$1"
    projectPath="$2"
    scriptType="$3"

    if [[ "$4" =~ "-code|-[c](?!.)" ]]
        then
        openInCode=false
    fi

else
    echo "$0: Too few arguments"
    exit 1
fi

if [[ "$scriptType" =~ "[wlb]" ]]
    then
    echo "Invalid script type $scriptType"
    exit 1
fi

# Paths are relative to this file!
psScriptSourcePath="./psScripts"
shScriptSourcePath="./shScripts"
cmakeTemplatePath="./CMakeLists.txt"

if [[ $projectPath = ".*" ]] || [[ $projectPath = "." ]]
    then
    # Relative path, turn to absolute
    projectPath="$originalDir/$projectPath"
fi

projectPath="$projectPath/$projectName"
mkdir -p "$projectPath"

# C/C++
mkdir -p "$projectPath/include"
mkdir -p "$projectPath/src"
touch "$projectPath/src/main.cpp"

# CMake
cp "./$cmakeTemplatePath" "$projectPath"

# Set CMake project name
sed -i "s/\(project(\).*\()\)/\1$projectName VERSION 0.1.0\2/" "$projectPath/CMakeLists.txt"
# Scripts
scriptType=$(echo "$scriptType" | tr '[:upper:]' '[:lower:]')
if [[ "$scriptType" == "l" || "$scriptType" == "b" ]]; then
    cp -r "./$shScriptSourcePath" "$projectPath/shellScripts"
fi

if [[ "$scriptType" == "w" || "$scriptType" == "b" ]]; then
    cp -r "./$psScriptSourcePath" "$projectPath/powershellScripts"
fi

echo "Project $projectName successfully created at $projectPath"

if [[ openInCode ]]
    then
    code $projectPath &
fi

cd "$originalDir"