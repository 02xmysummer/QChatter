import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Rectangle {
    id:centerControlArea
    property string thisQml: ""
    ColumnLayout {
        anchors.fill: centerControlArea
        spacing: 0
        //上侧搜索栏
        Rectangle {
            Layout.fillWidth: true
            height: 60
            color:"#F7F7F7"
            Rectangle {
                width: parent.width * 0.9
                height: parent.height * 0.4
                anchors.centerIn: parent
                radius: 5
                RowLayout {
                    anchors.fill: parent
                    spacing: 10
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color:"#E2E2E2"
                        radius: 5
                        RowLayout {
                            anchors.fill: parent
                            spacing: 10
                            BorderImage {
                                source: "qrc:/src/images/chat.png"
                                width: 22; height: 22
                            }
                            Text {
                                text:qsTr("搜索")
                            }
                        }
                    }
                    Rectangle {
                        width: 26
                        height: width
                        color:"#E2E2E2"
                        radius: 5
                    }
                }
            }
        }
        Loader {
            source: centerControlArea.thisQml
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
