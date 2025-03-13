import QtQuick
import QtQuick.Effects

Image {
    id: image
    property alias radius: maskRect.radius
    layer.enabled: true
    layer.effect: MultiEffect {
        maskEnabled: true
        maskSource: maskRect
    }
    Rectangle {
        id:maskRect
        anchors.fill: parent
        layer.enabled: true
        visible: false
    }


}
