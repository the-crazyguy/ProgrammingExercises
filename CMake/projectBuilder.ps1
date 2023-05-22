$ErrorActionPreference = "Stop" #Stop on error

$originalDir = $PWD
Set-Location $PSScriptRoot/..

if ($args.Count -eq 0)
{
    $projectName = Read-Host -Prompt "Project name"
    $projectPath = Read-Host -Prompt "Project path"
    $scriptType = Read-host -Prompt "Scripts for (Linux = l, Windows = w, Both = b)"
}
elseif ($args.Count -gt 3) 
{
    Write-Output "Too many arguments"
    exit 1
}
elseif ($args.Count -eq 3)
{
    # 3 Arguments
    $projectName = $args[0]
    $projectPath = $args[1]
    $scriptType = $args[2]
}
else 
{
    # < 3 args
    Write-Output "$($MyInvocation.MyCommand.Name): Too few arguments"
    exit 1
}

if ( $scriptType -notmatch "[wlb]" )
{
    Write-Host "Invalid script type"
    exit 1
}

#Paths relative to this file
$psScriptSourcePath = "./psScripts"
$shScriptSourcePath = "./shScripts"
$cmakeTemplatePath = "./CMakeLists.txt"

if ($projectPath.StartsWith(".")) 
{
    #Path is relative
    $projectPath = Join-Path $PWD $projectPath
}

$projectPath = Join-Path $projectPath $projectName

New-Item -ItemType Directory -Force -Path "$projectPath" | Out-Null

# C/C++
mkdir $projectPath/include | Out-Null
mkdir $projectPath/src | Out-Null
New-Item -Type File -Path $projectPath/src/main.cpp | Out-Null

# CMake
Copy-Item -Path (Join-Path $PSScriptRoot $cmakeTemplatePath) -Destination $projectPath | Out-Null

# Set CMake project name
$cmakeContents = Get-Content -Path $projectPath/CMakeLists.txt -Raw
$cmakeContents = $cmakeContents -Replace "(?<=project\()(.*?)(?=\ )", $projectName
Set-Content -Path $projectPath/CMakeLists.txt -Value $cmakeContents

# Scripts
$scriptType = $scriptType.ToLower();
if ($scriptType -eq "l" -or $scriptType -eq "b") 
{
    Copy-Item -Path (Join-Path "./" $shScriptSourcePath) -Destination $projectPath/shellScripts -Recurse -PassThru | Out-Null
}

if ($scriptType -eq "w" -or $scriptType -eq "b") 
{
    Copy-Item -Path (Join-Path "./" $psScriptSourcePath) -Destination $projectPath/powershellScripts -Recurse -PassThru | Out-Null
}

Write-Output "Project $projectName successfully created at $projectPath"

Set-Location $originalDir