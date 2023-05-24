& $PSScriptRoot/updateSourceList.ps1

$originalDir = $PWD
Set-Location $PSScriptRoot/..

mkdir -Force ./build    #-Force supresses the error message if the folder already exists. It does NOT delete the contents inside
Set-Location ./build
cmake ../

Set-Location $originalDir