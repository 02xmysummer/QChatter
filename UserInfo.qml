import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
/******************************************************************************
*
* @file       UserInfo.qml
*              用户详细信息
* @author     xuorz
* @date       2025/03/17
* @history
*****************************************************************************/
ColumnLayout {
    property var backgroundColor: "#F5F5F5"
    property var userInfo: {
        "name":p_object.name,
        "avatar":p_object.avatar,
        "uuid":p_object.uuid,
        "region":p_object.region,
    }

    spacing: 0
    Rectangle {
        Layout.fillWidth: true
        height: 30
        color: "transparent"
    }
    Rectangle {
        Layout.fillWidth: true
        height: 80
        color: backgroundColor

    }
    Rectangle {
        Layout.fillWidth: true
        height: 80
        color: backgroundColor
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin:30
            Image {
                Layout.preferredWidth: 60   // 使用 Layout 属性
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignVCenter  // 垂直居中
                source: userInfo.avatar
                fillMode: Image.PreserveAspectFit  // 保持宽高比
            }
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing:0
                Text {
                    text:userInfo.name
                    font.bold:true
                    font.pixelSize:14
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        text: "微信号: "
                        color: "#9E9E9E"
                    }
                    TextEdit {
                        text: userInfo.uuid
                        color: "#9E9E9E"
                        readOnly: true
                        selectByMouse: true
                        selectedTextColor: "white"
                        selectionColor: "#2196F3"
                    }
                }

                RowLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        text: "地区: "
                        color: "#9E9E9E"
                    }
                    TextEdit {
                        text: userInfo.region
                        color: "#9E9E9E"
                        readOnly: true
                        selectByMouse: true
                        selectedTextColor: "white"
                        selectionColor: "#2196F3"
                    }
                }
            }
            Rectangle {
                Layout.fillWidth:true
                Layout.fillHeight:true
                color: backgroundColor
            }
        }
    }
    Rectangle {
        Layout.fillWidth:true
        height:60
        color: backgroundColor
        RowLayout {
            anchors.fill: parent
            spacing: 30
            anchors.leftMargin: 20
            Text {
                text: "备注"
                color: "#9E9E9E"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignVCenter  // 垂直居中
            }
            Text {
                text: "点击添加昵称"
                color: "#9E9E9E"
                font.pixelSize: 16
                Layout.alignment: Qt.AlignVCenter  // 垂直居中
                MouseArea {
                    anchors.fill: parent
                    onClicked:{
                        console.log("点击添加昵称")
                    }
                }
            }
            // TextInput{

            // }

            Item{
                Layout.fillWidth:true
                Layout.fillHeight:true
            }
        }

    }

    Rectangle {
        Layout.fillWidth:true
        height:60
        color: backgroundColor
        ColumnLayout {

        }
    }
    Rectangle {
        Layout.fillWidth:true
        Layout.fillHeight:true
        color:"blue"
    }
}
