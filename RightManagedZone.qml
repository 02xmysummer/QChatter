import QtQuick


Rectangle {
    id:rightManagedZone
    property string thisQml: "ChatArea.qml"

    property string chatName: ""
    ChatArea {
        anchors.fill: parent
        visible: thisQml === "ChatArea.qml"
    }
    UserInfoArea {
        anchors.fill: parent
        visible: thisQml === "UserInfoArea.qml"
    }
}
