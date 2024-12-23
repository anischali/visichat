cmake_minimum_required(VERSION 3.21.1)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

project(visichat VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Multimedia)

qt_standard_project_setup(REQUIRES 6.5)

add_compile_options(-g -ggdb -O0)
add_link_options(-g -ggdb -O0)

qt_add_executable(appvisichat
    sources/main.cpp
    sources/qchat.hpp
    sources/qchat.cpp
    sources/servers.hpp
)

qt_add_qml_module(appvisichat
    URI visichat
    VERSION 1.0
    QML_FILES
        views/ChatMsgItem.qml
        views/ChatMsgsPage.qml
        views/ChatMsg.qml
        views/QrCodeView.qml
        views/QrCodeLoad.qml
        views/MainApp.qml
        views/MainWindow.qml

    RESOURCES
        resources/visichat.qrc
        configs/external_deps.cmake
        resources/images/mesgs.png
        resources/images/calls.png
        resources/images/contacts.png
        resources/images/import.png
        resources/images/search.png
        resources/images/share.png
        resources/images/offline.png
        resources/images/online.png
        resources/images/busy.png
        resources/images/info.png
        resources/images/attach.png
        resources/images/record.png
        resources/images/send.png
        resources/images/call.png
        resources/images/back.png
        resources/images/test.png
        resources/images/default-avatar.png
        android/AndroidManifest.xml
        android/build.gradle
        android/res/values/libs.xml
        android/res/xml/qtprovider_paths.xml
        android/gradle/wrapper/gradle-wrapper.jar
        android/gradle/wrapper/gradle-wrapper.properties
        android/gradle.properties
        android/gradlew
        android/gradlew.bat
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
    Qt6::Multimedia
    fmt::fmt
    Qbackend
    nlohmann_json
    lite-p2p
    ZXing::ZXing
)

set_property(TARGET appvisichat APPEND PROPERTY
    QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
)
if (ANDROID)
    FetchContent_Declare(
        android_openssl
        DOWNLOAD_EXTRACT_TIMESTAMP true
        URL https://github.com/KDAB/android_openssl/archive/refs/heads/master.zip
    )
    FetchContent_MakeAvailable(android_openssl)
    include(${android_openssl_SOURCE_DIR}/android_openssl.cmake)
    add_android_openssl_libraries(appvisichat)
    target_compile_definitions(appvisichat PUBLIC
        QT_ANDROID_MIN_SDK_VERSION=24
    )
endif()

include(GNUInstallDirs)
install(TARGETS appvisichat
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
