import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

/******************************************************************************
 *
 * @file       RegisterPage.qml
 *              注册界面
 * @author     xuorz
 * @date       2025/03/13
 * @history
 *****************************************************************************/
Rectangle{
    id: registerPage
    width: 280
    height: 350
    signal switchLogin

    color: "#f5f5f5"

    Column {
        anchors.fill: parent
        spacing: 15
        anchors.margins: 30

        // 邮箱输入框和验证码
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


        // 用户名输入框
        TextField {
            id: usernameInput
            width: parent.width - 34
            height: 30
            placeholderText: "请输入用户名"
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: usernameInput.focus ? "#2196F3" : "#e0e0e0"
            }
        }

        // 密码输入框
        TextField {
            id: passwordInput
            width: parent.width - 34
            height: 30
            placeholderText: "请输入密码"
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: passwordInput.focus ? "#2196F3" : "#e0e0e0"
            }
        }

        // 确认密码输入框
        TextField {
            id: confirmPasswordInput
            width: parent.width - 34
            height: 30
            placeholderText: "请确认密码"
            echoMode: TextInput.Password
            anchors.horizontalCenter: parent.horizontalCenter
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: confirmPasswordInput.focus ? "#2196F3" : "#e0e0e0"
            }
        }

        //验证码区域
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
                    text: sendCodeButton.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 12
                }
                onClicked: {
                    console.log("获取验证码")
                }
            }
        }

        // 注册按钮
        Button {
            id: registerButton
            text: "注 册"
            width: parent.width - 40
            height: 35
            anchors.horizontalCenter: parent.horizontalCenter
            flat: true
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: "#198754"
                color: registerButton.hovered ? "#157347" : "#198754"
            }
            contentItem: Text {
                text: registerButton.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 16
            }
            onClicked: {
                console.log("登录")
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
                onClicked: registerPage.switchLogin()
            }
        }
    }
}
