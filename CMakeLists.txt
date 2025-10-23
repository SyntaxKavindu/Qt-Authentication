cmake_minimum_required(VERSION 3.16)

project(Authentication VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 COMPONENTS Quick REQUIRED)
# qt_standard_project_setup()

add_subdirectory(src/Main/)
add_subdirectory(src/Qml/)
add_subdirectory(src/Core/Authentication/)
