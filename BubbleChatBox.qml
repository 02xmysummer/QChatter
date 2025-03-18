import QtQuick
import QtQuick.Layouts

/******************************************************************************
 *
 * @file       BubbleChatBox.qml
 *              聊天气泡框
 * @author     xuorz
 * @date       2025/03/18
 * @history
 *****************************************************************************/
Rectangle {
    id: bubble
    property string avatar: ""
    property string userName: ""
    property string message: ""
    property bool isSelf: false
    // 整体高度根据内容自适应
    height: rowLayout.implicitHeight + 20
    color: "#F5F5F5"
    RowLayout {
        id: rowLayout
        layoutDirection:isSelf ? Qt.LeftToRight : Qt.RightToLeft
        spacing: 8
        anchors {
            fill: parent
            rightMargin: isSelf ? 20 : 0
            leftMargin: isSelf ? 0 : 20
        }
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ColumnLayout {
            id: messageLayout
            Layout.alignment: Qt.AlignVCenter
            spacing: 4

            Text {
                id: nameText
                text: userName
                font.pixelSize: 12
                color: "#666666"
                Layout.alignment: isSelf?  Qt.AlignRight : Qt.AlignLeft
            }

            Rectangle {
                id: messageBubble
                Layout.preferredWidth: Math.min(messageText.implicitWidth + 16, parent.parent.width * 0.7)
                // 高度根据文本内容自适应
                implicitHeight: messageText.implicitHeight + 16
                radius: 8
                color: "#95EC69"

                Text {
                    id: messageText
                    anchors {
                        fill: parent
                        margins: 8
                    }
                    text: message
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    width: parent.width - 16  // 确保文本有正确的换行宽度
                    font.pixelSize: 14
                    color: "#000000"
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: 40
            Layout.preferredHeight: 40
            Layout.alignment: Qt.AlignTop  // 改为顶部对齐
            radius: width/2
            clip: true

            Image {
                anchors.fill: parent
                source: avatar
                fillMode: Image.PreserveAspectCrop
            }
        }
    }
}
