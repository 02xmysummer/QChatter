import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: main
    color: "transparent"  // 设置为透明
    z:0
    RowLayout {
        anchors.fill: main
        spacing: 0

        LeftNavBar {
            id:leftNavBar
            Layout.preferredWidth: 56
            Layout.fillHeight: true
            color: "#2E2E2E"
        }

        CenterControlArea {
            id:centerControlArea
            Layout.preferredWidth: 224
            Layout.fillHeight: true
            thisQml:leftNavBar.navBarList[leftNavBar.currentIndex]
        }

        RightManagedZone {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "transparent"
        }

    }
}
