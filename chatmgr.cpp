#include "chatmgr.h"
#include <QDir>
#include <QFile>
#include <QByteArray>
#include <QJsonParseError>
#include <QJsonArray>
#include "usermgr.h"
ChatMgr::ChatMgr(QObject *parent)
    : QObject{parent}
{}

void ChatMgr::UpdateChatList()
{
    QDir dir(".");
    dir.cdUp(); // 返回上级目录
    dir.cdUp(); // 再次返回上级目录
    QString jsonPath = dir.absoluteFilePath("statics/chatlist.json");
    QFile jsonFile(jsonPath);
    //没有这个文件
    if (!QFile::exists(jsonPath)) {
        qDebug() << "发送网络请求获取该文件" << jsonPath;
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
        QJsonArray jsonArray = jsonDoc.array();
        QJsonArray new_objArray;
        for (const QJsonValue &value : jsonArray) {
            if (value.isObject()) {
                QJsonObject obj = value.toObject();
                QJsonObject new_obj;
                QString uuid = obj["uuid"].toString();
                QJsonObject user = UserMgr::GetInstance()->GetUserInfo(uuid);
                new_obj["name"] = user["name"];
                new_obj["avatar"] = user["avatar"];
                if (obj["message"].isArray()) {
                    QJsonArray messageArray = obj["message"].toArray();
                    if (!messageArray.isEmpty() && messageArray.at(0).isObject()) {
                        QJsonObject lastMessageObj = messageArray.at(0).toObject();
                        new_obj["lasttext"] = lastMessageObj["text"];
                        new_obj["lasttime"] = lastMessageObj["time"];
                    }
                }
                // 只有当 new_obj 被正确填充时才添加到数组中
                if (!new_obj.isEmpty()) {
                    new_objArray.append(new_obj);
                }
            }
        }
        QJsonDocument new_jsonDoc(new_objArray);

        QByteArray byteArray = new_jsonDoc.toJson();
        emit sig_update_chatlist_finish(byteArray);
    }
}
