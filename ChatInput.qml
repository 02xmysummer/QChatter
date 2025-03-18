import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Dialogs

/******************************************************************************
 *
 * @file       ChatInput.qml
 *              聊天内容输入框
 * @author     xuorz
 * @date       2025/03/18
 * @history
 *****************************************************************************/
Rectangle {
    signal sendMessage(var message)
    color: "#F5F5F5"
    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 0  // 移除间隙


        //顶部工具栏
        Rectangle {
            height: 30
            Layout.fillWidth: true
            color: "#F5F5F5"
            RowLayout {
                anchors.leftMargin: 10
                spacing: 10
                anchors.fill: parent
                // 表情按钮
                HoverImage {
                    width: 20
                    height: 20
                    color: "#F5F5F5"
                    defaultSource: "qrc:/src/images/emoji.png"
                    // hoverSource:
                }

                // 文件按钮
                HoverImage {
                    width: 20
                    height: 20
                    color: "#F5F5F5"
                    defaultSource: "qrc:/src/images/folder_black.png"
                    onClicked: {
                        fileDialog.open()
                    }
                }
                HoverImage {
                    width: 20
                    height: 20
                    color: "#F5F5F5"
                    defaultSource: "qrc:/src/images/screenshot.png"
                    hoverSource: "qrc:/src/images/hoverdscreenshot.png"
                }
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
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
                    if(messageInput.text === "")
                        return
                    console.log("send message:", messageInput.text)
                    var message = {
                        "userName": "xmy",
                        "avatar": "qrc:/src/images/avatar.jpg",
                        "text":messageInput.text,
                    }
                    sendMessage(message)
                    messageInput.clear()
                    messageInput.forceActiveFocus()  // 添加这一行，强制获取焦点

                }
            }
        }
    }


    FileDialog {
        id: fileDialog
        title: "选择文件"
        nameFilters: [
            "所有文件 (*.*)",
            "图片文件 (*.jpg *.jpeg *.png *.gif *.bmp *.webp)"
        ]
        onAccepted: {
            console.log("选择的文件:", fileDialog.selectedFile)
        }
    }
}
