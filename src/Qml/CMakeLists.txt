qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)

qt_add_library(QmlLib STATIC)

set_target_properties(QmlLib PROPERTIES AUTORCC ON)

qt_add_qml_module(QmlLib
    URI Qml
    VERSION 1.0
    RESOURCE_PREFIX "/"
    QML_FILES Main.qml
    QML_FILES Login.qml
    QML_FILES Home.qml
    QML_FILES Loading.qml
    QML_FILES DeviceCard.qml
    QML_FILES ToggleSwitch.qml
)

target_link_libraries(QmlLib
    PRIVATE Qt6::Quick
)

