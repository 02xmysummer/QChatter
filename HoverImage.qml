import QtQuick
/******************************************************************************
 *
 * @file       HoverImage.qml
 *              自定义图片
 * @author     xuorz
 * @date       2025/03/18
 * @history
 *****************************************************************************/
Rectangle {
    id: hoverImage
    property bool isHovered: false
    property url defaultSource: ""
    property url hoverSource: ""
    signal clicked()
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        Image {
            id: img
            anchors.fill: parent
            source: defaultSource
        }
        onClicked: {
            hoverImage.clicked()
        }

        onEntered: {
            hoverImage.isHovered = true
            if (hoverSource.toString() !== "") {
                img.source = hoverSource
            }
        }

        onExited: {
            hoverImage.isHovered = false
            img.source = defaultSource
        }
    }
}
