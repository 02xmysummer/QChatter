import QtQuick
import QtQuick.Controls
import io.chatmgr 1.0
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


    Connections {
        target: ChatMgr
        function onSig_update_chatlist_finish(res) {
            var objs = JSON.parse(res)
            for(const obj of objs){
                dataModel.append(obj)
            }
        }
    }

    // 添加滚动条
    ScrollBar.vertical: ScrollBar {
        active: true
    }
    ListModel {
        id: dataModel
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
    // Component.onCompleted:{
    //     p_object.chatName = dataModel.get(0).name
    // }
}
