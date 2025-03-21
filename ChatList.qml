import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Controls.Material
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

        function onSig_switch_curchat_finish(uuid) {
            //查找ListModel，id为dataModel的每一项，将activeIndex切换为项中uuid为uuid的一项
            for (var i = 0; i < dataModel.count; i++) {
                if (dataModel.get(i).uuid === uuid) {
                    chatList.activeIndex = i
                    break
                }
            }
        }

        function onSig_create_chat_finish(res) {
            var obj = JSON.parse(res)
            dataModel.insert(0, obj)
            chatList.activeIndex = 0
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
            if(activeIndex === index)
                return
            activeIndex = index
            ChatMgr.GetChatHistory(uuid)
            console.log("重新加载用户")
        }
        onMoveTop: {
            if(index > 0) {
                dataModel.move(index, 0, 1)
                console.log("dataModel.move(index, 0, 1)")
            }
        }
        onRemove:{
            confirmDialog.index = index
            confirmDialog.uuid = uuid
            confirmDialog.open()
        }
    }

    MessageDialog {
        id:confirmDialog
        property int index: -1
        property string uuid: ""
        text: qsTr("删除聊天后，将同时删除聊天记录中的所有内容")
        buttons: MessageDialog.Ok | MessageDialog.Cancel

        onAccepted: {
            dataModel.remove(index)
            ChatMgr.RemoveChat(uuid)
            index = -1
            uuid = ""
        }
        onRejected: {
            index = -1
            uuid = ""
        }
    }

}
