import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Rectangle {
    id:rightManagedZone
    ColumnLayout {
        anchors.fill: rightManagedZone
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            height: 60
            color: "transparent"
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color:"red"
        }
    }
}
