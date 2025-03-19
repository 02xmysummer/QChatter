import QtQuick
import QtQuick.Layouts
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
            source: ("file:\\" + model.avatar) || ""
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            text: model.name || ""
            font.pixelSize: 14
            font.bold: true
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
        onClicked: {
            console.log("clicked.............")
            chatListDelegate.clicked()
            p_object.avatar =  model.avatar
            p_object.name =  model.name
            p_object.uuid =  model.uuid
            p_object.region =  model.region
        }
    }
}
