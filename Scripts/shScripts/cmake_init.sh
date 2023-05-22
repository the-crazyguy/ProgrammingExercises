# Create a directory named "build" in the current directory, suppressing error message if it already exists
originalDir="$(pwd)"
bashDir="$(dirname -- $BASH_SOURCE)"
cd "${bashDir}/.."

mkdir -p ./build
cd ./build
cmake ../
cd ..

cd "$originalDir"