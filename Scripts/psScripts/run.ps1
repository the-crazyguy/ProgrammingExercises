$originalDir = $PWD
Set-Location $PSScriptRoot/..


$cmakePath = "./CMakeLists.txt"

$projectInfo = Select-String -Path $cmakePath -Pattern "project\("

$projectInfo -match "(?<=project\()(.*?)(?=\ )" | Out-Null
$projectName = $Matches[0]

# TODO/QOL: Search the build directory if $projectName.exe exists and prompt user to take action if it does not

# Note: Set-Location is reverted so that terminating the executable does not leave the user in an unwanted directory
Set-Location $originalDir
# Note: If the executable's name is different from the project name, replace $projectName with the proper name
& $PSScriptRoot/../build/$projectName.exe
