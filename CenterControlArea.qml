import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Rectangle {
    id:centerControlArea
    property string thisQml: ""
    property string previousQml: ""

    ColumnLayout {
        anchors.fill: centerControlArea
        spacing: 0
        //上侧搜索栏
        Rectangle {
            Layout.fillWidth: true
            height: 60
            RowLayout {
                width: parent.width * 0.9
                height: parent.height * 0.4
                anchors.centerIn: parent
                spacing:4
                SearchBox {
                    id:searchBox
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    onClicked:{
                        previousQml = thisQml
                        thisQml = "SearchList.qml"
                    }
                    onExited: {
                        thisQml = previousQml
                    }
                }
                Rectangle {
                    width:24
                    Layout.fillHeight: true
                    color:"#E2E2E2"
                    Rectangle {
                        id:rect1
                        width: 12
                        height: 1
                        anchors.centerIn:parent
                        color:"#ADADAD"
                        visible:true
                    }
                    Rectangle {
                        id:rect2
                        width: 1
                        height: 12
                        anchors.centerIn:parent
                        color:"#ADADAD"
                        visible:rect1.visible
                    }
                    Image {
                        id:img
                        source:"qrc:/src/images/adduser.png"
                        anchors.centerIn: parent
                        width:16
                        height :width
                        visible:false
                    }
                }
            }
        }
        ChatList {
            id:chatList
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: thisQml === "ChatList.qml"

        }
        UserList {
            id:userList
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: thisQml === "UserList.qml"
        }

        SearchList{
            id:searchList
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: thisQml === "SearchList.qml"
        }
    }
}
