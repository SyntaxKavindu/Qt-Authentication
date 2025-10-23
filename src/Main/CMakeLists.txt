qt_add_executable(Authentication main.cpp)

target_link_libraries(Authentication
    PRIVATE Qt6::Quick
    PRIVATE QmlLibplugin
    PRIVATE AuthLib
)

set_target_properties(Authentication PROPERTIES
    WIN32_EXECUTABLE TRUE
)
