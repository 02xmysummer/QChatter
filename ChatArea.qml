import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import io.usermgr 1.0
import io.chatmgr 1.0
/******************************************************************************
 *
 * @file       ChatArea.qml
 *              聊天区域
 * @author     xuorz
 * @date       2025/03/18
 * @history
 *****************************************************************************/
ColumnLayout {
    id:chatArea
    anchors.fill: parent
    spacing: 0

    property string name: p_object.chatName

    Connections {
        target: ChatMgr
        function onSig_get_chathistory_finish(res) {
            var obj = JSON.parse(res)
            chatContent.clearMessage()
            if(obj.history.length === 0)
                return;
            var self = UserMgr.GetSelfInfo()
            for(var i = obj.history.length - 1; i >= 0; i--) {
                var item = obj.history[i]
                if(item.isSelf) {
                    chatContent.appendMessage(
                                self.avatar, self.name, item.text, true
                                )
                }else {
                    chatContent.appendMessage(
                                obj.avatar, chatArea.name, item.text, false
                                )
                }
            }
        }
    }

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
