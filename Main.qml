import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import com.example.singletons
import com.example.global
ApplicationWindow {
    id: root
    visible: true
    width: 360
    height: 640
    title: "注册"
    color: "#f5f5f5"

    // 定义常用颜色和样式
    readonly property color primaryColor: "#2196F3"
    readonly property color textColor: "#333333"
    readonly property int animationDuration: 200
    readonly property real defaultRadius: 8

    // 验证码倒计时
    property int countdown: 0
    Timer {
        id: countdownTimer
        interval: 1000
        repeat: true
        onTriggered: {
            if (countdown > 0) {
                countdown--
            } else {
                stop()
                verifyCodeBtn.enabled = true
            }
        }
    }

    Rectangle {
        id: container
        width: parent.width * 0.9
        height: parent.height * 0.85
        anchors.centerIn: parent
        color: "white"
        radius: defaultRadius
        border.color: "#E0E0E0"
        border.width: 1

        ColumnLayout {
            anchors {
                fill: parent
                margins: 20
            }
            spacing: 16

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "注册账号"
                font {
                    pixelSize: 24
                    weight: Font.Medium
                    family: "Microsoft YaHei"
                }
                color: textColor
            }

            // 邮箱输入
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4

                            Text {
                                text: "邮箱地址"
                                font.pixelSize: 14
                                color: "#666666"
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                height: 45
                                radius: defaultRadius
                                color: "#f5f5f5"
                                // 修改边框颜色逻辑
                                border.color: {
                                    if (emailField.text.length === 0) return "transparent"
                                    if (emailField.activeFocus) return primaryColor
                                    return emailField.acceptableInput ? "transparent" : "#FF0000"
                                }
                                border.width: 1

                                TextField {
                                    id: emailField
                                    anchors.fill: parent
                                    placeholderText: "请输入邮箱地址"
                                    font.pixelSize: 16
                                    color: textColor
                                    background: null
                                    leftPadding: 15
                                    selectByMouse: true

                                    validator: RegularExpressionValidator {
                                        regularExpression: /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/
                                    }
                                }
                            }

                            // 添加邮箱错误提示
                            Text {
                                text: "请输入正确的邮箱格式"
                                color: "#FF0000"
                                font.pixelSize: 12
                                visible: emailField.text.length > 0 && !emailField.acceptableInput
                            }
                        }

                        // 密码输入
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4

                            Text {
                                text: "密码"
                                font.pixelSize: 14
                                color: "#666666"
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                height: 45
                                radius: defaultRadius
                                color: "#f5f5f5"
                                // 修改边框颜色逻辑
                                border.color: {
                                    if (passwordField.text.length === 0) return "transparent"
                                    if (passwordField.activeFocus) return primaryColor
                                    return passwordField.text.length >= 8 ? "transparent" : "#FF0000"
                                }
                                border.width: 1

                                TextField {
                                    id: passwordField
                                    anchors.fill: parent
                                    placeholderText: "请输入密码（至少8位）"
                                    font.pixelSize: 16
                                    color: textColor
                                    background: null
                                    leftPadding: 15
                                    echoMode: TextField.Password
                                    selectByMouse: true

                                    validator: RegularExpressionValidator {
                                        regularExpression: /.{8,}/
                                    }
                                }
                            }

                            // 添加密码长度错误提示
                            Text {
                                text: "密码长度不能少于8位"
                                color: "#FF0000"
                                font.pixelSize: 12
                                visible: passwordField.text.length > 0 && passwordField.text.length < 8
                            }
                        }

                        // 确认密码
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4

                            Text {
                                text: "确认密码"
                                font.pixelSize: 14
                                color: "#666666"
                            }

                            Rectangle {
                                Layout.fillWidth: true
                                height: 45
                                radius: defaultRadius
                                color: "#f5f5f5"
                                // 修改边框颜色逻辑
                                border.color: {
                                    if (confirmPasswordField.text.length === 0) return "transparent"
                                    if (confirmPasswordField.activeFocus) return primaryColor
                                    return passwordField.text === confirmPasswordField.text ? "transparent" : "#FF0000"
                                }
                                border.width: 1

                                TextField {
                                    id: confirmPasswordField
                                    anchors.fill: parent
                                    placeholderText: "请再次输入密码"
                                    font.pixelSize: 16
                                    color: textColor
                                    background: null
                                    leftPadding: 15
                                    echoMode: TextField.Password
                                    selectByMouse: true
                                }
                            }

                            Text {
                                id: passwordError
                                text: "两次输入的密码不一致"
                                color: "#FF0000"
                                font.pixelSize: 12
                                visible: confirmPasswordField.text.length > 0 &&
                                        passwordField.text !== confirmPasswordField.text
                            }
                        }

            // 验证码输入区域
                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 4

                            Text {
                                text: "验证码"
                                font.pixelSize: 14
                                color: "#666666"
                            }

                            RowLayout {
                                Layout.fillWidth: true
                                spacing: 8

                                Rectangle {
                                    Layout.fillWidth: true
                                    height: 45
                                    radius: defaultRadius
                                    color: "#f5f5f5"
                                    border.color: verifyCodeField.activeFocus ? primaryColor : "transparent"
                                    border.width: 1

                                    TextField {
                                        id: verifyCodeField
                                        anchors.fill: parent
                                        placeholderText: "请输入验证码"
                                        font.pixelSize: 16
                                        color: textColor
                                        background: null
                                        leftPadding: 15
                                        selectByMouse: true
                                        validator: RegularExpressionValidator {
                                            regularExpression: /^\d{6}$/
                                        }
                                    }
                                }

                                Button {
                                    id: verifyCodeBtn
                                    Layout.preferredWidth: 120
                                    Layout.preferredHeight: 45
                                    // 修改启用条件：邮箱格式正确 且 密码符合要求 且 两次密码一致 且 不在倒计时中
                                    enabled: emailField.acceptableInput &&
                                            passwordField.acceptableInput &&
                                            passwordField.text === confirmPasswordField.text &&
                                            passwordField.text.length >= 8 &&
                                            countdown === 0

                                    contentItem: Text {
                                        text: countdown > 0 ? `重新发送(${countdown}s)` : "获取验证码"
                                        font.pixelSize: 14
                                        color: "white"
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                    }

                                    background: Rectangle {
                                        radius: defaultRadius
                                        color: parent.enabled ? (parent.pressed ? Qt.darker(primaryColor, 1.1) : primaryColor) : "#CCCCCC"

                                        Behavior on color {
                                            ColorAnimation {
                                                duration: animationDuration
                                            }
                                        }
                                    }

                                    onClicked: {
                                        if (enabled) {
                                            var json_obj = {}
                                            json_obj["email"] = emailField.text
                                            HttpMgr.PostHttpReq(
                                                "http://192.168.56.101:8080/get_varifycode",
                                                json_obj,
                                                Global.ID_GET_VARIFY_CODE,
                                                Global.REGISTERMOD
                                            )
                                            countdown = 60
                                            countdownTimer.start()
                                        }
                                    }
                                }
                            }
                        }

            // 注册按钮
            Button {
                Layout.fillWidth: true
                Layout.preferredHeight: 45
                Layout.topMargin: 20
                enabled: emailField.acceptableInput &&
                        passwordField.acceptableInput &&
                        passwordField.text === confirmPasswordField.text &&
                        verifyCodeField.acceptableInput

                contentItem: Text {
                    text: "注册"
                    font {
                        pixelSize: 16
                        weight: Font.Medium
                    }
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    radius: defaultRadius
                    color: parent.enabled ? (parent.pressed ? Qt.darker(primaryColor, 1.1) : primaryColor) : "#CCCCCC"

                    Behavior on color {
                        ColorAnimation {
                            duration: animationDuration
                        }
                    }
                }

                onClicked: {
                    if (enabled) {
                        var json_obj = {
                            "email": emailField.text,
                            "password": passwordField.text,
                            "verify_code": verifyCodeField.text
                        }
                        HttpMgr.PostHttpReq(
                            "http://192.168.56.101:8080/register",
                            json_obj,
                            Global.ID_REGISTER,
                            Global.REGISTERMOD
                        )
                    }
                }
            }

            // 已有账号登录
            Text {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 16
                text: "已有账号？ <a href='#'>立即登录</a>"
                font.pixelSize: 14
                color: "#666666"
                linkColor: primaryColor
                onLinkActivated: {
                    // TODO: 切换到登录页面
                    console.log("切换到登录页面")
                }
            }
        }
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: false
        visible: running
    }
}
