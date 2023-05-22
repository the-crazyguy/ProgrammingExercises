$originalDir = $PWD
Set-Location $PSScriptRoot/..

cmake --build ./build

Set-Location $originalDir