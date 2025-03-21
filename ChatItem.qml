import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import io.chatmgr 1.0
/******************************************************************************
 *
 * @file       ChatItem.qml
 *             聊天列表项
 * @author     xuorz
 * @date       2025/03/17
 * @history
 *****************************************************************************/
Rectangle {
    id:chatListDelegate

    property bool isActive: false


    // 添加点击信号
    signal clicked()

    signal moveTop()
    signal remove()
    width: parent.width
    height: 60
    color: isActive ? "#C8C7C6" : (mouseArea.containsMouse ? "#DEDCDA" : "#E5E4E4")

    Row {
        width: parent.width
        height: parent.height
        spacing: 12
        padding: 10

        // 头像
        Image {
            width: 40
            height: width
            source: model.avatar || ""
            anchors.verticalCenter: parent.verticalCenter
        }

        // 中间的名称和消息
        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 120  // 留出头像和时间的空间
            spacing: 4

            Text {
                text: model.name || ""
                font.pixelSize: 16
                color: "#000000"
                elide: Text.ElideRight  // 文本过长时显示省略号
                width: parent.width
            }

            Text {
                text: model.lasttext || ""
                font.pixelSize: 14
                color: "#666666"
                elide: Text.ElideRight
                width: parent.width
            }
        }

        // 时间
        Text {
            text: model.lasttime || ""
            font.pixelSize: 12
            color: "#999999"
            anchors.top: parent.top
            anchors.topMargin: parent.padding
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: function(mouse){
            if(mouse.button === Qt.LeftButton) {
                chatListDelegate.clicked()  // 触发点击信号
                p_object.chatName = model.name
            } else {
                contextMenu.popup()
            }

        }
        Menu {
            id: contextMenu

            MenuItem {
                text: qsTr("置顶")
                onTriggered: {
                    chatItem.moveTop()
                }
            }

            MenuSeparator { }

            MenuItem {
                text: qsTr("删除消息")
                onTriggered: {
                    chatItem.remove()
                }
            }
        }
    }
}
