import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
/******************************************************************************
 *
 * @file       ChatContent.qml
 *              聊天区域
 * @author     xuorz
 * @date       2025/03/17
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


    Rectangle {
        Layout.fillWidth: true
        Layout.fillHeight: true
        color:"red"
    }

    Rectangle {
        Layout.fillWidth: true
        height: 120

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            spacing: 0  // 移除间隙


            //顶部工具栏
            Rectangle {
                height: 30
                Layout.fillWidth: true

                Row {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    spacing: 10
                    height: parent.height

                    // 表情按钮
                    Image {
                        width: 20
                        height: 20
                        source: "qrc:/src/images/chat_active.png"  // 需要添加表情图标资源
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    // 文件按钮
                    Image {
                        width: 20
                        height: 20
                        source: "qrc:/src/images/folder_black.png"   // 需要添加文件图标资源
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        width: 20
                        height: 20
                        source: "qrc:/src/images/folder_black.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.preferredHeight: 60
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                clip: true

                TextArea {
                    id: messageInput
                    width: parent.width
                    height: Math.max(implicitHeight, parent.height)
                    wrapMode: TextArea.Wrap
                    font.pointSize: 12
                    selectByMouse: true
                    verticalAlignment: TextArea.AlignTop

                    // 移除边框
                    background: Rectangle {
                        color: "transparent"
                    }
                    // 添加光标颜色设置
                    cursorDelegate: Rectangle {
                        width: 1
                        color: "black"
                    }
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: 30
                color: "transparent"

                Button {
                    anchors.right: parent.right
                    width: 68
                    height: 32
                    anchors.verticalCenter: parent.verticalCenter

                    hoverEnabled: true

                    background: Rectangle {
                        id: buttonBackground
                        color: parent.hovered ? "#06AE56" : "#07C160"
                        radius: 4
                    }

                    contentItem: Text {
                        text: "发送"
                        color: "white"
                        font.pixelSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: {
                        console.log("send message:", messageInput.text)
                        messageInput.text = ""
                        messageInput.forceActiveFocus()  // 添加这行，强制获取焦点
                    }
                }
            }
        }
    }
}
