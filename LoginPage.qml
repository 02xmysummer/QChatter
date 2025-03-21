import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import io.httpmgr 1.0
import io.global 1.0
import io.usermgr 1.0
import io.chatmgr 1.0
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

    Connections {
        target: HttpMgr

        function onSig_login_mod_finish(id, res, errorcode) {
            console.log("id is ", id)
            console.log("res is ", res)
            console.log("errorcode is ", errorcode)
            if(errorcode !== Global.SUCCESS) {
                console.log("网络请求错误")
                return
            }

            if(id === Global.ID_LOGIN_USER) {
                // 解析返回的 JSON 字符串
                let response = JSON.parse(res)
                // 检查服务器返回的错误码
                if(response.error === 0) {
                    console.log("登录成功")
                    loginPage.login()
                } else {
                    console.log("登录失败：服务器返回错误")
                }
            }
        }
    }

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
        //用户名
        TextField {
            id: usernameInput
            width: parent.width - 34
            height: 30
            placeholderText: "请输入邮箱"
            anchors.horizontalCenter:parent.horizontalCenter
            background: Rectangle {
                radius: 4
                border.width: 1
                border.color: usernameInput.focus ? "#2196F3" : "#e0e0e0"
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
                var json_obj = {
                    "user": usernameInput.text,
                    "passwd": passwordInput.text
                }
                loginPage.login()

                UserMgr.UpdateFriendList()
                ChatMgr.UpdateChatList()
                // HttpMgr.PostHttpReq("http://192.168.56.101:8080/user_login", json_obj, Global.ID_LOGIN_USER, Global.LOGINMOD)

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
