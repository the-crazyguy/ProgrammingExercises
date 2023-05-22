#!/bin/bash
set -o errexit

originalDir="$(pwd)"
bashDir="$(dirname -- $BASH_SOURCE)"
cd "${bashDir}"

./build.sh
./buildAndRun.sh

cd "${originalDir}"