cmake_minimum_required(VERSION 3.12.0)
project(Proj5 VERSION 0.1.0)

set(CXX_STANDARD 11)
set(CXX_STANDARD_REQUIRED True)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

add_executable(${PROJECT_NAME} )
include(sourceList)

target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include)