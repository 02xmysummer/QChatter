import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
/******************************************************************************
 *
 * @file       ChatArea.qml
 *              聊天区域
 * @author     xuorz
 * @date       2025/03/18
 * @history
 *****************************************************************************/
ColumnLayout {
    anchors.fill: parent
    spacing: 0

    property string name: p_object.chatName
    Item {
        Layout.fillWidth: true
        height: 60
        Rectangle {
            id:topRect
            width: parent.width
            height: 30
            color: "transparent"

        }
        Rectangle {
            width: parent.width
            height: 30
            color: "#F5F5F5"
            anchors.top:topRect.bottom
        }
        Text {
            id:title
            anchors {
                left: parent.left        // 左对齐父元素
                leftMargin: 20          // 左侧距离20
                verticalCenter: parent.verticalCenter  // 垂直居中
            }
            text: name
            font.pixelSize: 20
        }
    }


    //消息记录框
    ChatContent {
        id:chatContent
        Layout.fillWidth: true
        Layout.fillHeight: true

    }


    //底部消息输入框
    ChatInput {
        id:chatInput
        Layout.fillWidth: true
        height: 120
        onSendMessage: function(message){
            chatContent.appendMessage(message.avatar, message.userName, message.text, true)
        }
    }
}
