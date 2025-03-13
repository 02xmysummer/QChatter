import QtQuick
import an.io 1.0
import QtQuick.Layouts
/******************************************************************************
 *
 * @file       FramelessWindow.qml
 *  封装的无边框窗口
 * @author     xuorz
 * @date       2025/03/05
 * @history
 *****************************************************************************/
FramelessWindow {
    id:framelesswindow
    property var defalt_color: "#F5F5F5"
    property var hoverd_color: "#E2E2E2"
    property var x_color: "#4A4A4A"
    property bool tipTopBtnShow: true
    property bool minBntShow: true
    property bool maxBntShow: true
    property bool quitBntShow: true
    // 顶部移动
    Rectangle {
        id:titleBar
        width: parent.width
        height: 30
        color:framelesswindow.defalt_color

        RowLayout {
            z: 2
            anchors.fill: parent
            //左侧空白占位
            Item {
                height: parent.height
                Layout.fillWidth: true
            }
            //置顶窗口按钮

            Rectangle{
                property bool isHoverd: false
                property bool isTop: false
                width: 40
                height: 30
                color: isHoverd?  framelesswindow.hoverd_color : framelesswindow.defalt_color
                visible: framelesswindow.tipTopBtnShow
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    Image {
                        id:img
                        source: "qrc:/src/images/pinTop.png"
                        anchors.centerIn: parent
                        width: parent.width * 0.3
                        height: width
                    }

                    onClicked: {
                        parent.isTop = !parent.isTop
                        framelesswindow.setWindowFlag(parent.isTop)
                        img.source = parent.isTop ? "qrc:/src/images/QpinTop.png" : "qrc:/src/images/pinTop.png"

                    }
                    onEntered: {
                        parent.isHoverd = true
                    }
                    onExited: {
                        parent.isHoverd = false
                    }
                }
            }
            //最小化窗口按钮

            Rectangle{
                property bool isHoverd: false
                width: 40
                height: 30
                color: isHoverd?  framelesswindow.hoverd_color : framelesswindow.defalt_color
                visible: framelesswindow.minBntShow
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width * 0.3
                        height: 1
                        color: framelesswindow.x_color
                    }

                    onClicked: {
                        framelesswindow.showMinimized()
                    }
                    onEntered: {
                        parent.isHoverd = true
                    }
                    onExited: {
                        parent.isHoverd = false
                    }
                }
            }

            //最大化窗口按钮
            Rectangle{
                property bool isHoverd: false
                width: 40
                height: 30
                color: isHoverd?  framelesswindow.hoverd_color : framelesswindow.defalt_color
                visible: framelesswindow.maxBntShow
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width * 0.3
                        height: parent.height * 0.3
                        color: "transparent"  // 设置颜色为透明，以使其为空心
                        border.color: framelesswindow.x_color
                        border.width: 1
                    }

                    onClicked: {
                        console.log("max")
                        if(framelesswindow.visibility === Window.Maximized) {
                            framelesswindow.showNormal()
                        } else {
                            framelesswindow.showMaximized()
                        }
                    }
                    onEntered: {
                        parent.isHoverd = true
                    }
                    onExited: {
                        parent.isHoverd = false
                    }
                }
            }

            //退出窗口按钮
            Rectangle{
                property bool isHoverd: false
                width: 40
                height: 30
                color: isHoverd?  framelesswindow.hoverd_color : framelesswindow.defalt_color
                visible: framelesswindow.quitBntShow
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width * 0.3
                        height: 1
                        rotation: 45
                        color:"black"
                    }
                    Rectangle {
                        anchors.centerIn: parent
                        width: parent.width * 0.3
                        height: 1
                        rotation: -45
                        color:"black"
                    }

                    onClicked: {
                        console.log("quit")
                        Qt.quit()
                    }
                    onEntered: {
                        parent.isHoverd = true
                    }
                    onExited: {
                        parent.isHoverd = false
                    }
                }
            }
        }


        //拖拽功能
        MouseArea {
            property var click_pos: Qt.point(0,0)
            anchors.fill: parent
            onPositionChanged: function(mouse) {
                if(!pressed || (framelesswindow.mouse_pos !== FramelessWindow.NORMAL))
                    return

                if(!framelesswindow.startSystemMove()) { //启动系统自带的拖拽功能
                    var offset = Qt.point(mouseX - click_pos.x, mouseY - click_pos.y)
                    framelesswindow.x += offset.x
                    framelesswindow.y += offset.y
                }
            }
            onPressedChanged: function(mouse) {
                click_pos = Qt.point(mouseX, mouseY)
            }
            onDoubleClicked:{
                if(!framelesswindow.is_resize) return;

                if(framelesswindow.visibility === Window.Maximized) {
                    framelesswindow.showNormal()
                } else {
                    framelesswindow.showMaximized()
                }
            }
        }
    }

}
