import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Rectangle {
    id:rightManagedZone
    ColumnLayout {
        anchors.fill: rightManagedZone
        spacing: 0

        Item {
            Layout.fillWidth: true
            height: 60
            Rectangle {
                id:topRect
                width: parent.width
                height: 30
                color: "transparent"

            }
            Rectangle {
                width: parent.width
                height: 30
                color: "#F5F5F5"
                anchors.top:topRect.bottom
            }
        }


        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color:"red"
        }

        Rectangle {
            Layout.fillWidth: true
            height: 80
            color: "blue"
        }
    }
}
