import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import io.httpmgr 1.0
import io.global 1.0
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

    Connections {
        target: HttpMgr
        function onSig_reg_mod_finish(id, res, errorcode) {
            console.log("id is ", id)
            console.log("res is ", res)
            console.log("errorcode is ", errorcode)
            if(errorcode !== Global.SUCCESS) {
                console.log("网络请求错误")
                return
            }

            //获取验证码成功
            if(id === Global.ID_GET_VARIFY_CODE) {
                console.log("获取验证码成功")
            }else if(id === Global.ID_REG_USER) {
                console.log("注册成功")
                registerPage.switchLogin()
            }
        }
    }

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
                text: remainingTime > 0 ? remainingTime + "秒" : "发送验证码"
                flat: true
                enabled: remainingTime === 0
                background: Rectangle {
                    radius: 4
                    border.width: 1
                    border.color: sendCodeButton.enabled ? "#198754" : "#cccccc"
                    color: {
                        if (!sendCodeButton.enabled) return "#cccccc"
                        return sendCodeButton.hovered ? "#157347" : "#198754"
                    }
                }
                contentItem: Text {
                    text: sendCodeButton.text
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 12
                }

                property int remainingTime: 0
                Timer {
                    id: countdownTimer
                    interval: 1000
                    repeat: true
                    onTriggered: {
                        sendCodeButton.remainingTime--
                        if (sendCodeButton.remainingTime <= 0) {
                            stop()
                        }
                    }
                }

                onClicked: {
                    function isValidEmail(email) {
                        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
                        return emailRegex.test(email)
                    }

                    if(!isValidEmail(emailInput.text))
                    {
                        console.log("邮箱错误")
                        return
                    }
                    var json_obj = {
                        "email": emailInput.text
                    }
                    HttpMgr.PostHttpReq("http://192.168.56.101:8080/get_varifycode", json_obj, Global.ID_GET_VARIFY_CODE, Global.REGISTERMOD)

                    // 启动倒计时
                    remainingTime = 60
                    countdownTimer.start()
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
                var json_obj = {
                    "email": emailInput.text,
                    "user": usernameInput.text,
                    "passwd": passwordInput.text,
                    "confirm": confirmPasswordInput.text,
                    "varifycode": codeInput.text
                }
                HttpMgr.PostHttpReq("http://192.168.56.101:8080/user_register", json_obj, Global.ID_REG_USER, Global.REGISTERMOD)

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
