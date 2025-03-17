import QtQuick


Rectangle {
    id:rightManagedZone
    property string thisQml: "ChatContent.qml"

    property string chatName: ""
    ChatContent {
        anchors.fill: parent
        visible: thisQml === "ChatContent.qml"
    }
    UserInfo {
        anchors.fill: parent
        visible: thisQml === "UserInfo.qml"
    }
}
