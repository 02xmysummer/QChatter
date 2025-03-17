import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: main
    color: "transparent"  // 设置为透明\
    QtObject {
        id: p_object
        property string chatName: ""
        property var avatar: ""
        property string name: ""
        property string uuid: ""
        property string region: ""
    }

    z:0
    property var leftNavBarList: [
        "ChatList.qml", "UserList.qml","ChatList.qml","ChatList.qml","ChatList.qml"
    ]
    property var rightList: [
        "ChatContent.qml","UserInfo.qml","ChatContent.qml","ChatContent.qml","ChatContent.qml"
    ]
    RowLayout {
        anchors.fill: main
        spacing: 0

        LeftNavBar {
            id:leftNavBar
            Layout.preferredWidth: 56
            Layout.fillHeight: true
            color: "#2E2E2E"
            onCurrentIndexChanged: {
                centerControlArea.thisQml = leftNavBarList[leftNavBar.currentIndex]
                rightManagedZone.thisQml = rightList[leftNavBar.currentIndex]
            }
        }

        CenterControlArea {
            id:centerControlArea
            Layout.preferredWidth: 224
            Layout.fillHeight: true
            thisQml: "ChatList.qml"
        }

        RightManagedZone {
            id:rightManagedZone
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
            thisQml:"ChatContent.qml"

        }

    }
}
