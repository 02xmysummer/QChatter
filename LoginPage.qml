import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material


/******************************************************************************
 *
 * @file       LoginPage.qml
*               登录界面
 * @author     xuorz
 * @date       2025/03/13
 * @history
 *****************************************************************************/
Rectangle {
    id: loginPage
    width: 280
    height: 350
    color: "#f5f5f5"


    signal switchRegister
    signal switchForgetPassword
    signal login
    Column {
        anchors.fill: parent
        spacing: 20
        anchors.margins: 30

        //头像
        RoundImage {
            width: 100
            height: width
            radius: width
            anchors.horizontalCenter:parent.horizontalCenter
            source: "qrc:/src/images/avatar.jpg"
        }
        //邮箱
        TextField {
            id: emailInput
            width: parent.width - 34
            height: 30
            placeholderText: "请输入邮箱"
            anchors.horizontalCenter:parent.horizontalCenter
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: emailInput.focus ? "#2196F3" : "#e0e0e0"
            }
        }
        //密码
        TextField {
            id: passwordInput
            width: parent.width - 34
            height: 30
            placeholderText: "请输入密码"
            anchors.horizontalCenter:parent.horizontalCenter
            echoMode: TextInput.Password
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: passwordInput.focus ? "#2196F3" : "#e0e0e0"
            }
        }
        //登录按钮
        Button {
            id: loginButton
            text: "登 录"
            width: parent.width - 40
            height: 35
            anchors.horizontalCenter: parent.horizontalCenter

            // 取消默认的按钮样式
            flat: true

            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: "#198754"
                color: {
                    if (loginButton.hovered) return "#157347"    // 悬停时深绿
                    return "#198754"                             // 正常状态绿色
                }

                // Add MouseArea for cursor change
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onPressed: loginButton.pressed()
                    onReleased: loginButton.released()
                }
            }

            contentItem: Text {
                text: parent.text
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 16
            }

            onClicked: {
                loginPage.login()
            }
        }

        // 添加注册和忘记密码的行
        Row {
            width: parent.width - 40
            height: 30
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            Text {
                id: registerText
                text: "注册账号"
                color: registerArea.containsMouse ? "#666666" : "#999999"
                font.pixelSize: 14
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    id: registerArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log("register")
                        loginPage.switchRegister()
                        console.log("register")
                    }
                }
            }

            Item {
                width: parent.width - registerText.width - forgetText.width - parent.spacing * 2
                height: 1
            }

            Text {
                id: forgetText
                text: "忘记密码"
                color: forgetArea.containsMouse ? "#666666" : "#999999"
                font.pixelSize: 14
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    id: forgetArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        loginPage.switchForgetPassword()
                    }
                }
            }
        }
    }
}
