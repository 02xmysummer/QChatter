import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

FramelessWindow {
    id: window
    width: loader.width
    height: loader.height + 30
    visible: true

    Loader {
        id: loader
        y: 30
        source: "LoginPage.qml"

        Connections {
            target: loader.item
            ignoreUnknownSignals: true
            function onSwitchRegister() {
                loader.source = "RegisterPage.qml"
            }

            function onSwitchLogin() {
                loader.source = "LoginPage.qml"
            }
            function onSwitchForgetPassword() {
                loader.source = "ForgetPasswordPage.qml"
            }
        }

        onLoaded: {
            // 使用 toString() 并检查是否包含目标文件名
            var sourcePath = loader.source.toString()
            if(sourcePath.includes("LoginPage.qml") || sourcePath.includes("RegisterPage.qml") ||
                    sourcePath.includes("ForgetPasswordPage.qml")) {
                window.is_resize = false
                window.minBntShow = false
                window.maxBntShow = false
            }
        }
    }
}
