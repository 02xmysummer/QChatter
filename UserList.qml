import QtQuick
import QtQuick.Controls
import io.usermgr 1.0
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

    Connections {
        target: UserMgr
        function onSig_update_friendlist_finish(res) {
            var users =  JSON.parse(res)
            for(const user of users){
                dataModel.append(user)
            }
            console.log("dataModel.count is",dataModel.count)
        }
    }

    boundsBehavior:Flickable.StopAtBounds
    ScrollBar.vertical: ScrollBar {
        active: true
        // policy: ScrollBar.AlwaysOn  // Always show scrollbar
    }
    ListModel {
        id: dataModel
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
    }
}
