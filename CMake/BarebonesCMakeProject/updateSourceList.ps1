$sourceFolderPath = "./src"
$targetFileFolderPath = "./cmake"
$outputFileName = "sourceList.cmake"
$fileContents = "target_sources(`${PROJECT_NAME} PRIVATE`n"

$cppFiles = (Get-Item $sourceFolderPath/*.cpp)
$cFiles = (Get-Item $sourceFolderPath/*.c)

foreach ($currentFile in $cppFiles) {
    $nameAndExtension = $currentFile.BaseName + $currentFile.Extension
    $fileContents += "`t`t`t`t`"$sourceFolderPath/$nameAndExtension`"`n"
}

foreach ($currentFile in $cFiles) {
    $nameAndExtension = $currentFile.BaseName + $currentFile.Extension
    $fileContents += "`t`t`t`t`"$sourceFolderPath/$nameAndExtension`"`n"
}

#This stays in case someone decides to add more sub-folders to src
$folders = (Get-ChildItem -Directory ./test -Recurse).FullName
foreach ($folder in $folders) 
{
    $cppFiles = (Get-ChildItem $folder/*.cpp)
    $cFiles = (Get-ChildItem $folder/*.c)

    foreach ($currentFile in $cppFiles) {
        $replacedSlashes = "$currentFile"        
        $replacedSlashes = $replacedSlashes.Replace("\","/")
        $fileContents += "`t`t`t`t`"$replacedSlashes`"`n"
    }

    foreach ($currentFile in $cFiles) {
        $replacedSlashes = "$currentFile"
        $replacedSlashes = $replacedSlashes.Replace("\","/")
        $fileContents += "`t`t`t`t`"$replacedSlashes`"`n"
    }
}

$fileContents += "`t`t`t`t)"

mkdir -Force $targetFileFolderPath | Out-Null

Set-Content -Path $targetFileFolderPath/$outputFileName -Value $fileContents