import QtQuick
import QtQuick.Controls
import QtQuick.Window
import com.example.singletons
import com.example.global
ApplicationWindow {
    visible: true
    width: 300
    height: 400
    title: "Login and Register"

    Row {
        anchors.fill: parent
        TextField{
            id:t
        }
        Button{
            text:"获取验证码"
            width: 100
            height:30
            onClicked: {
                var json_obj = {}
                json_obj["email"] = t.text
                HttpMgr.PostHttpReq("http://192.168.56.101:8080/get_varifycode",json_obj,Global.ID_GET_VARIFY_CODE,Global.REGISTERMOD)
            }
        }
    }
}
