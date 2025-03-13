import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

/******************************************************************************
 *
 * @file       ForgetPasswordPage.qml
 *              忘记密码界面
 * @author     xuorz
 * @date       2025/03/13
 * @history
 *****************************************************************************/
Rectangle {
    id: forgetPasswordPage
    width: 280
    height: 350
    color: "#f5f5f5"
    signal switchLogin

    Column {
        anchors.fill: parent
        spacing: 15
        anchors.margins: 30

        // 邮箱输入框
        TextField {
            id: emailInput
            width: parent.width - 34
            height: 30
            placeholderText: "请输入邮箱"
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: emailInput.focus ? "#2196F3" : "#e0e0e0"
            }
        }

        // 验证码输入框和发送按钮
        Row {
            width: parent.width - 34
            height: 30
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            TextField {
                id: codeInput
                width: parent.width - 90
                height: 30
                placeholderText: "验证码"
                background: Rectangle {
                    radius: 4
                    border.width: 1
                    border.color: codeInput.focus ? "#2196F3" : "#e0e0e0"
                }
            }

            Button {
                id: sendCodeButton
                width: 80
                height: 30
                text: "发送验证码"
                flat: true
                background: Rectangle {
                    radius: 4
                    border.width: 1
                    border.color: "#198754"
                    color: sendCodeButton.hovered ? "#157347" : "#198754"
                }
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 12
                }
            }
        }

        // 新密码输入框
        TextField {
            id: newPasswordInput
            width: parent.width - 34
            height: 30
            placeholderText: "请输入新密码"
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: newPasswordInput.focus ? "#2196F3" : "#e0e0e0"
            }
        }

        // 确认新密码输入框
        TextField {
            id: confirmPasswordInput
            width: parent.width - 34
            height: 30
            placeholderText: "请确认新密码"
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: confirmPasswordInput.focus ? "#2196F3" : "#e0e0e0"
            }
        }

        // 重置密码按钮
        Button {
            id: resetButton
            text: "重置密码"
            width: parent.width - 40
            height: 35
            anchors.horizontalCenter: parent.horizontalCenter
            flat: true
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: "#198754"
                color: resetButton.hovered ? "#157347" : "#198754"
            }
            contentItem: Text {
                text: parent.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 16
            }
        }

        // 返回登录
        Text {
            id: backToLoginText
            text: "返回登录"
            color: backToLoginArea.containsMouse ? "#666666" : "#999999"
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                id: backToLoginArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: forgetPasswordPage.switchLogin()
            }
        }
    }
}
