originalDir="$(pwd)"
bashDir="$(dirname -- $BASH_SOURCE)"
cd "${bashDir}/.."

cmake --build ./build

cd "$originalDir"