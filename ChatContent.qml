import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

/******************************************************************************
 *
 * @file       ChatContent.qml
 *             聊天内容区域
 * @author     xuorz
 * @date       2025/03/18
 * @history
 *****************************************************************************/
Rectangle {
    color: "#F5F5F5"
    border.width:1
    border.color:"#E7E7E7"
    ListView {
        id:messageList
        clip: true  // 防止内容溢出
        boundsBehavior:Flickable.StopAtBounds
        anchors.fill: parent
        property int activeIndex: 0
        spacing:10

        // 添加滚动条
        ScrollBar.vertical: ScrollBar {
            active: true
        }
        model: ListModel {
            id: messageModel
        }
        delegate: BubbleChatBox {
            width: messageList.width
            // height: 40
            avatar: model.avatar
            userName: model.userName
            message: model.message
            isSelf: model.isSelf
        }
    }
    function appendMessage(avatar, userName, message, isSelf) {
        messageModel.append({
            "avatar": avatar,
            "userName": userName,
            "message": message,
            "isSelf": isSelf
        })
        messageList.positionViewAtEnd()
    }

}

