cmake_minimum_required(VERSION 3.21.1)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(visichat VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appvisichat
    sources/main.cpp
)

qt_add_qml_module(appvisichat
    URI visichat
    VERSION 1.0
    QML_FILES
        views/MainWindow.qml
    RESOURCES
        resources/visichat.qrc
        configs/external_deps.cmake
)

qt_add_resources(appvisichat "configuration"
    URI visichat/resources
    PREFIX "/"
    FILES
        resources/qtquickcontrols2.conf
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appvisichat PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appvisichat
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(configs/external_deps.cmake)

target_include_directories(appvisichat PRIVATE
    includes/
)

target_link_libraries(appvisichat PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    fmt::fmt
    Qbackend
    nlohmann_json
)


include(GNUInstallDirs)
install(TARGETS appvisichat
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
