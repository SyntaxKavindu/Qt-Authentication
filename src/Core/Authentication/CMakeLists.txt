add_library(AuthLib STATIC
    LoginAuthentication.h
    LoginAuthentication.cpp
)

target_link_libraries(AuthLib
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Network
)


target_include_directories(AuthLib
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)
