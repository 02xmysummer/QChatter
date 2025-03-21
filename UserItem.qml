import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import io.chatmgr 1.0
/******************************************************************************
 *
 * @file       UserItem.qml
 *              用户列表项
 * @author     xuorz
 * @date       2025/03/17
 * @history
 *****************************************************************************/
Rectangle {
    id:chatListDelegate
    height: 60
    property bool isActive: false
    // 添加点击信号
    signal clicked()
    color: isActive ? "#C8C7C6" : (mouseArea.containsMouse ? "#DEDCDA" : "#E5E4E4")
    Row {
        width: parent.width
        height: parent.height
        spacing: 12
        padding: 10

        // 头像
        Image {
            width: 30
            height: width
            source: model.avatar|| ""
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: model.name || ""
            font.pixelSize: 14
            color: "#000000"
            elide: Text.ElideRight  // 文本过长时显示省略号
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton  // 同时接受左键和右键
        onClicked:function(mouse) {
            if (mouse.button === Qt.LeftButton) {
                chatListDelegate.clicked()
                p_object.avatar =  model.avatar
                p_object.name =  model.name
                p_object.uuid =  model.uuid
                p_object.region =  model.region
            } else {
                contextMenu.uuid = model.uuid
                contextMenu.popup()
            }
        }
        Menu {
            id: contextMenu
            property string uuid: ""
            MenuItem {
                text: qsTr("发消息")
                onTriggered: {
                    if(uuid === "")
                        return
                    ChatMgr.CreateChat(uuid)
                    uuid = ""
                }
            }

            MenuSeparator { }

            MenuItem {
                text: qsTr("删除好友")
                onTriggered: {
                    // 处理删除逻辑
                }
            }
        }

    }



}
