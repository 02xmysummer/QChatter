import QtQuick
import QtQuick.Controls
/******************************************************************************
 *
 * @file       ChatList.qml
 *              聊天列表
 * @author     xuorz
 * @date       2025/03/16
 * @history
 *****************************************************************************/
ListView {
    id:chatList
    clip: true  // 防止内容溢出
    boundsBehavior:Flickable.StopAtBounds
    property int activeIndex: 0

    // 添加滚动条
    ScrollBar.vertical: ScrollBar {
        active: true
    }
    ListModel {
        id: dataModel
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "张三xxx"; status: "今天天气真不错"; time: "14:25" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "李四"; status: "要一起去吃饭吗？"; time: "14:20" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "王五"; status: "收到文件了吗？"; time: "14:15" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小明"; status: "下班了吗？"; time: "13:50" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小红"; status: "项目进展如何？"; time: "13:30" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "老王"; status: "周末有空吗？"; time: "13:20" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小张"; status: "会议改到下午三点"; time: "12:55" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小李"; status: "文档我已经修改完了"; time: "12:30" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "王五"; status: "收到文件了吗？"; time: "14:15" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小明"; status: "下班了吗？"; time: "13:50" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小红"; status: "项目进展如何？"; time: "13:30" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "老王"; status: "周末有空吗？"; time: "13:20" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小张"; status: "会议改到下午三点"; time: "12:55" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小李"; status: "文档我已经修改完了"; time: "12:30" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "王五"; status: "收到文件了吗？"; time: "14:15" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小明"; status: "下班了吗？"; time: "13:50" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小红"; status: "项目进展如何？"; time: "13:30" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "老王"; status: "周末有空吗？"; time: "13:20" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小张"; status: "会议改到下午三点"; time: "12:55" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小李"; status: "文档我已经修改完了"; time: "12:30" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "王五"; status: "收到文件了吗？"; time: "14:15" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小明"; status: "下班了吗？"; time: "13:50" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小红"; status: "项目进展如何？"; time: "13:30" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "老王"; status: "周末有空吗？"; time: "13:20" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小张"; status: "会议改到下午三点"; time: "12:55" }
        ListElement { avatar: "qrc:/src/images/avatar.jpg"; name: "小李"; status: "文档我已经修改完了"; time: "12:30" }
    }
    model: dataModel
    delegate: ChatItem {
        id:chatItem
        width: chatList.width
        isActive: index === chatList.activeIndex

        onClicked: {
            activeIndex = index
        }
    }
    Component.onCompleted:{
        p_object.chatName = dataModel.get(0).name
    }
}
