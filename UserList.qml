import QtQuick
import QtQuick.Controls
/******************************************************************************
 *
 * @file       UserList.qml
 *              用户列表
 * @author     xuorz
 * @date       2025/03/16
 * @history
 *****************************************************************************/
ListView {
    id:userList
    clip: true  // 防止内容溢出
    property int activeIndex: 0


    boundsBehavior:Flickable.StopAtBounds
    ScrollBar.vertical: ScrollBar {
        active: true
        // policy: ScrollBar.AlwaysOn  // Always show scrollbar
    }
    ListModel {
        id: dataModel
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "张三"
            uuid: "aB2c9D"
            region: "重庆市 渝中区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "李四"
            uuid: "Kj8mN2pQ"
            region: "重庆市 江北区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "王五"
            uuid: "x7YhV9"
            region: "重庆市 南岸区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小明"
            uuid: "Zt5WqL8n"
            region: "重庆市 沙坪坝区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小红"
            uuid: "R4kP9mX"
            region: "重庆市 九龙坡区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "老王"
            uuid: "bN7cK2vM"
            region: "重庆市 大渡口区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小张"
            uuid: "Hj6sQ9"
            region: "重庆市 巴南区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小李"
            uuid: "U3wF8nP"
            region: "重庆市 北碚区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "王五"
            uuid: "gT5mB9k"
            region: "重庆市 渝北区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小明"
            uuid: "E7vX2dL"
            region: "重庆市 江津区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小红"
            uuid: "A9pQ4mY"
            region: "重庆市 合川区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "老王"
            uuid: "Ws8kN3h"
            region: "重庆市 永川区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小张"
            uuid: "J5tC7bR"
            region: "重庆市 璧山区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小李"
            uuid: "M2xD8vP"
            region: "重庆市 铜梁区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "王五"
            uuid: "Q6yH4nK"
            region: "重庆市 潼南区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小明"
            uuid: "L9wF5mS"
            region: "重庆市 荣昌区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小红"
            uuid: "B3kT7gX"
            region: "重庆市 大足区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "老王"
            uuid: "Z8vP2cN"
            region: "重庆市 梁平区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小张"
            uuid: "Y4mH6qL"
            region: "重庆市 开州区"
        }
        ListElement {
            avatar: "qrc:/src/images/avatar.jpg"
            name: "小李"
            uuid: "G7tW9bK"
            region: "重庆市 武隆区"
        }
    }
    model: dataModel
    delegate: UserItem {
        width: userList.width
        isActive: index === userList.activeIndex

        onClicked: {
            userList.activeIndex = index
        }
    }

    Component.onCompleted:{
        p_object.name = dataModel.get(0).name
        p_object.avatar = dataModel.get(0).avatar
        p_object.uuid = dataModel.get(0).uuid
        p_object.region = dataModel.get(0).region
    }
}
