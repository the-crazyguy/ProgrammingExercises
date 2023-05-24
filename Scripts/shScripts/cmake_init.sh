originalDir="$(pwd)"
bashDir="$(dirname -- $BASH_SOURCE)"

$bashDir/updateSourceList.sh    # Not tested

cd "${bashDir}/.."

mkdir -p ./build
cd ./build
cmake ../
cd ..

cd "$originalDir"