#!/bin/bash
set -o errexit

originalDir="$(pwd)"
bashDir="$(dirname -- $BASH_SOURCE)"
cd "${bashDir}"

./updateSourceList.sh
./build.sh
./buildAndRun.sh

cd "${originalDir}"