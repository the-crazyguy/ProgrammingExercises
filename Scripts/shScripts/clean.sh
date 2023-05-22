originalDir="$(pwd)"
bashDir="$(dirname -- $BASH_SOURCE)"
cd "${bashDir}/.."

rm -r -f ./build

cd "$originalDir"