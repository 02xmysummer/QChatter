#include "chatmgr.h"
#include <QByteArray>
#include <QDir>
#include <QFile>
#include <QJsonArray>
#include <QJsonParseError>
#include "usermgr.h"
#include <QDateTime>
ChatMgr::ChatMgr(QObject *parent)
    : QObject{parent}
{
    QDir dir(".");
    dir.cdUp(); // 返回上级目录
    dir.cdUp(); // 再次返回上级目录
    QString jsonPath = dir.absoluteFilePath("statics/chatlist.json");
    _chatListPath = jsonPath;
}

void ChatMgr::UpdateChatList()
{

    QFile jsonFile(_chatListPath);
    //没有这个文件
    if (!QFile::exists(_chatListPath)) {
        qDebug() << "发送网络请求获取该文件" << _chatListPath;
        return; // 或其他错误处理
    }

    if (!jsonFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open JSON file.";
    }
    QByteArray jsonData = jsonFile.readAll();
    jsonFile.close();
    QJsonParseError parseError;
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData, &parseError);
    if (parseError.error != QJsonParseError::NoError) {
        qDebug() << "Failed to parse JSON:" << parseError.errorString();
        // return -1;
    }

    if (jsonDoc.isNull()) {
        qDebug() << "JSON document is null (empty data?)";
    }

    if (jsonDoc.isArray()) {
        QJsonArray userlist_jsonArray = jsonDoc.array();
        QJsonArray users_jsonArray;
        for (const QJsonValue &value : userlist_jsonArray) {
            if (value.isObject()) {
                QJsonObject obj = value.toObject();
                QJsonObject new_obj;
                QString uuid = obj["uuid"].toString();
                QJsonObject user = UserMgr::GetInstance()->GetUserInfo(uuid);
                new_obj["uuid"] = user["uuid"];
                new_obj["name"] = user["name"];
                new_obj["avatar"] = user["avatar"];
                if (obj["history"].isArray()) {
                    QJsonArray messageArray = obj["history"].toArray();
                    if (!messageArray.isEmpty() && messageArray.at(0).isObject()) {
                        QJsonObject lastMessageObj = messageArray.at(0).toObject();
                        new_obj["lasttext"] = lastMessageObj["text"];
                        new_obj["lasttime"] = lastMessageObj["time"];
                    }
                }
                // 只有当 new_obj 被正确填充时才添加到数组中
                if (!new_obj.isEmpty()) {
                    users_jsonArray.append(new_obj);
                    _chatList[uuid] = new_obj;
                }
            }
        }
        QJsonDocument new_jsonDoc(users_jsonArray);

        QByteArray byteArray = new_jsonDoc.toJson();
        emit sig_update_chatlist_finish(byteArray);
    }
}

void ChatMgr::GetChatHistory(const QString &uuid)
{
    // 先检查缓存
    if (_recentHistoryCache.contains(uuid)) {
        QJsonDocument res(_recentHistoryCache[uuid]);
        sig_get_chathistory_finish(res.toJson());
        // return _recentHistoryCache[uuid];
    }

    // 缓存中没有，从文件读取
    QFile jsonFile(_chatListPath);

    if (!jsonFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open JSON file.";
        // return QJsonArray();
    }

    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonFile.readAll());
    jsonFile.close();
    if (jsonDoc.isArray()) {
        QJsonArray jsonArray = jsonDoc.array();
        QJsonObject resObj;
        for (const QJsonValue &value : jsonArray) {
            if (value.isObject()) {
                QJsonObject obj = value.toObject();
                if (obj["uuid"].toString() == uuid) {
                    QJsonArray history = obj["history"].toArray();
                    // 添加到缓存
                    if (_recentHistoryCache.size() >= MAX_CACHE_SIZE) {
                        ClearOldCache();
                    }
                    QJsonObject user = UserMgr::GetInstance()->GetUserInfo(uuid);

                    obj["avatar"] = user["avatar"];
                    resObj = obj;
                    _recentHistoryCache[uuid] = resObj;

                    // return history;
                }
            }
        }
        QJsonDocument new_jsonDoc(resObj);
        emit sig_get_chathistory_finish(new_jsonDoc.toJson());
    }

    // return QJsonArray();
}
void ChatMgr::ClearOldCache() {
    // 这里可以实现不同的缓存清理策略
    // 例如：删除最早添加的记录，或最久未访问的记录
    if (!_recentHistoryCache.isEmpty()) {
        _recentHistoryCache.remove(_recentHistoryCache.firstKey());
    }
}

void ChatMgr::RemoveChat(const QString &uuid)
{
    //现在内存中删除
    _chatList.remove(uuid);
    deleteChat(uuid);
}

bool ChatMgr::deleteChat(const QString &uuid)
{
    QFile file(_chatListPath);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Failed to open file for reading";
        return false;
    }
    QByteArray jsonData = file.readAll();
    file.close();

    QJsonDocument doc = QJsonDocument::fromJson(jsonData);
    if (!doc.isArray()) {
        qDebug() << "JSON document is not an array";
        return false;
    }

    // 找到并删除指定 UUID 的对象
    QJsonArray array = doc.array();
    for (int i = 0; i < array.size(); ++i) {
        QJsonObject obj = array[i].toObject();
        if (obj["uuid"].toString() == uuid) {
            array.removeAt(i);
            break;
        }
    }

    // 写回文件
    doc.setArray(array);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Truncate)) {
        qDebug() << "Failed to open file for writing";
        return false;
    }

    file.write(doc.toJson());
    file.close();

    return true;
}

void ChatMgr::CreateChat(const QString &uuid)
{
    // 检查是否已存在
    if (_chatList.contains(uuid)) {
        emit sig_switch_curchat_finish(uuid);
        return;
    }

    // 写入内存
    QJsonObject newChat;
    newChat["uuid"] = uuid;
    QJsonObject user = UserMgr::GetInstance()->GetUserInfo(uuid);
    newChat["name"] = user["name"];
    newChat["avatar"] = user["avatar"];
    QDateTime currentTime = QDateTime::currentDateTime();
    newChat["lasttime"] = currentTime.toString("hh:mm");
    newChat["lasttext"] = "";
    _chatList[uuid] = newChat;

    QJsonDocument jsonDoc(newChat);

    emit sig_create_chat_finish(jsonDoc.toJson());
    // 写入文件
    QFile file(_chatListPath);
    if (!file.open(QIODevice::ReadWrite)) {
        qDebug() << "Failed to open chat list file:" << _chatListPath;
        return;
    }

    // 读取现有数据
    // 读取现有聊天记录
    QJsonDocument doc;
    QJsonArray chatArray;
    if (file.size() > 0) {
        QByteArray data = file.readAll();
        doc = QJsonDocument::fromJson(data);
        if (doc.isArray()) {
            chatArray = doc.array();
        }
    }

    // 添加新的空聊天记录
    QJsonObject chat;
    chat["uuid"] = uuid;
    chat["history"] = QJsonArray();  // 空的历史记录数组
    chatArray.prepend(chat);

    // 写回文件
    file.seek(0);
    file.resize(0);
    file.write(QJsonDocument(chatArray).toJson());
    file.close();

    jsonDoc = QJsonDocument(chat);
    emit sig_get_chathistory_finish(jsonDoc.toJson());


}

void ChatMgr::SendMessage(const QString &uuid, const QString &message)
{

}
