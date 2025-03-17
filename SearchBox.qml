import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
/******************************************************************************
 *
 * @file       SearchBox.qml
 *             搜索框组件
 * @author     xuorz
 * @date       2025/03/17
 * @history
 *****************************************************************************/
Rectangle {
    id:searchBox
    signal clicked()
    signal exited()
    color: searchInput.focus? "#F9F9F9" :"#E2E2E2"
    border.width: searchInput.focus? 1 : 0
    border.color: searchInput.focus? "black" : "#E2E2E2"
    radius:5
    RowLayout {
        anchors.fill:searchBox
        spacing: 4

        Image {
            source: "qrc:/src/images/search.png"
            height: 24
            width: 24
        }
        TextField {
            id:searchInput
            Layout.fillWidth: true
            Layout.fillHeight: true
            verticalAlignment: Text.AlignVCenter
            leftPadding: 0
            rightPadding: 0
            topPadding: 0
            bottomPadding: 0
            font.pixelSize: searchBox.height * 0.5
            placeholderText: focus ? "" : "搜索"

            background: Rectangle {
                color: "transparent"
            }

            cursorDelegate: Rectangle {
                width: 1
                color: "black"
            }

            selectByMouse: true
            selectionColor: "#E8E8E8"
            selectedTextColor: "black"
            onFocusChanged: {
                if(focus) {
                    closeBtn.visible = true
                    searchBox.clicked()
                } else{
                    closeBtn.visible = false
                }
            }
        }

        //关闭按钮
        Rectangle {
            id:closeBtn
            width:height
            height:searchBox.height * 0.6
            radius:width
            color:"#E2E2E2"
            visible: false
            Rectangle {
                anchors.centerIn: parent
                width: parent.width * 0.8
                height: 1
                rotation: 45
                color:"#929292"
            }
            Rectangle {
                anchors.centerIn: parent
                width: parent.width * 0.8
                height: 1
                rotation: -45
                color:"#929292"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    searchInput.clear()
                    searchInput.focus = false
                    searchBox.exited()
                 }
            }
        }

        Item {
            width:5
            Layout.fillHeight:true
        }
    }

}



