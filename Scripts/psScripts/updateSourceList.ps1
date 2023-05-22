$originalDir = $PWD
Set-Location $PSScriptRoot/..

$sourceFolderPath = "./src"
$targetFileFolderPath = "./cmake"
$outputFileName = "sourceList.cmake"
$fileContents = "target_sources(`${PROJECT_NAME} PRIVATE`n"

$sourceFiles = @(Get-ChildItem -Path $sourceFolderPath -Recurse -Filter '*.cpp') | Resolve-Path -Relative
$sourceFiles += @(Get-ChildItem -Path $sourceFolderPath -Recurse -Filter '*.c') | Resolve-Path -Relative

foreach ($currentFile in $sourceFiles) {
    $currentFile = $currentFile.Replace("\","/")
    $fileContents += "`t`t`t`t`"$currentFile`"`n"
}

$fileContents += "`t`t`t`t`)"

mkdir -Force $targetFileFolderPath | Out-Null

Set-Content -Path $targetFileFolderPath/$outputFileName -Value $fileContents

Set-Location $originalDir