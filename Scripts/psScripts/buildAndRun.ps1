$ErrorActionPreference = "Stop" #Stop on error
$originalDir = $PWD
Set-Location $PSScriptRoot

./build.ps1
./run.ps1

Set-Location $originalDir