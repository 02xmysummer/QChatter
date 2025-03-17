import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: leftNavBar
    property int currentIndex: 0


    ColumnLayout {
        anchors.fill: leftNavBar
        spacing: 10
        RoundButton {
            id:avatarButton
            property int icon_width:5 * leftNavBar.width / 6
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 30
            Layout.preferredWidth: icon_width
            Layout.preferredHeight: icon_width
            icon.source: "qrc:/src/images/avatar.jpg"
            icon.width: icon_width
            icon.height: icon_width
            icon.color: "transparent"
            background: Rectangle {
                radius: width/2
                color: "transparent"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true  // 启用悬浮检测
                cursorShape: Qt.PointingHandCursor  // 设置鼠标形状为手形
            }
        }
        ListView {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width
            spacing: 5
            model: ListModel {
                ListElement { icon: "chat"; active: true }
                ListElement { icon: "contacts"; active: false }
                ListElement { icon: "folder"; active: false }
                ListElement { icon: "chat"; active: false }
                ListElement { icon: "chat"; active: false }
            }

            delegate: Rectangle {
                width: parent.width
                height: 50
                color: "transparent"

                Image {
                    anchors.centerIn: parent
                    width: 22
                    height: 22
                    source: model.active ? "qrc:/src/images/" + model.icon + "_active.png" :
                                           "qrc:/src/images/" + model.icon + ".png"
                    opacity: model.active ? 1.0 : 0.5

                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        for (var i = 0; i < parent.ListView.view.model.count; i++) {
                            parent.ListView.view.model.setProperty(i, "active", i === index)
                        }
                        leftNavBar.currentIndex = index
                        console.log("current index is",index)
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        // 底部按钮
        ColumnLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.bottomMargin: 10
            spacing: 8

            RoundButton {
                Layout.preferredWidth: 40
                Layout.preferredHeight: 40
                icon.source: "qrc:/src/images/settings.png"
                icon.color: "white"
                background: Rectangle {
                    color: "transparent"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true  // 启用悬浮检测
                    cursorShape: Qt.PointingHandCursor  // 设置鼠标形状为手形
                }
            }
        }
    }
}
