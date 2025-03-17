cmake_minimum_required(VERSION 3.16)

project(QChatter VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Network)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appQChatter
    main.cpp
)

qt_add_qml_module(appQChatter
    URI QChatter
    VERSION 1.0
    QML_FILES
        Main.qml
        FramelessWindow.qml
        LoginPage.qml
        RegisterPage.qml
        RoundImage.qml
        ForgetPasswordPage.qml
        MainWindowPage.qml
        LeftNavBar.qml
        CenterControlArea.qml
        RightManagedZone.qml
        ChatList.qml
        UserList.qml
        ChatItem.qml
        UserItem.qml
        SearchBox.qml
        SearchList.qml
        ChatContent.qml
        UserInfo.qml
    SOURCES
        Singleton.h
        httpmgr.h
        httpmgr.cpp
        global.h
        framelesswindow.h
        framelesswindow.cpp
    RESOURCES rc.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appQChatter PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appQChatter
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appQChatter
    PRIVATE Qt6::Quick
        Qt6::Network
)

include(GNUInstallDirs)
install(TARGETS appQChatter
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
