$originalDir = $PWD
Set-Location $PSScriptRoot/..

Remove-Item -r ./build -ErrorAction SilentlyContinue

Set-Location $originalDir