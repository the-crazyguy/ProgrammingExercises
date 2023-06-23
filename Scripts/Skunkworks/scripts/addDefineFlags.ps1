$originalDir = $PWD
Set-Location $PSScriptRoot/..

$cmakePath = "./CMakeLists.txt"
$cmakeCompileDefitinionsCommand = "add_compile_definitions("
# Note: do not escape parenthases in bash?
$cmakeCompileDefinitionsCommandRegexMask = "add_compile_definitions\(.*?\)"

#TODO:
# 1. Get CMake contents into variable/array
# 2. Look for cmakeCompileDefinitionsCommandRegexMask
# 3. Delete if it exists
# 4. Add the required definitions
#    4.1 Pass define flags to this script
#    4.2 Create the definitions command
#    4.3 Add to CMake contents var/array
#    4.4 Write the new contents to the file 



Set-Location $originalDir