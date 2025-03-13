import QtQuick
import QtQuick.Effects

Image {
    id: image
    property alias radius: maskRect.radius
    layer.enabled: true

    Rectangle {
        id:maskRect
        anchors.fill: parent
        layer.enabled: true
        visible: false
    }

    layer.effect: MultiEffect {
        maskEnabled: true
        maskSource: maskRect
    }

}
