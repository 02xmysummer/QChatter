#include "usermgr.h"
#include <QFile>
#include <QDebug>
#include <QByteArray>
#include <QDir>
#include <QJsonParseError>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
UserMgr::UserMgr(QObject *parent)
    : QObject{parent}
{
    _self["name"] = "123";
    _self["avatar"] = "";
    _self["uuid"] = "123";
    _self["token"] = "123";
}

QJsonObject UserMgr::GetUserInfo(QString &uuid)
{
    return _friendList[uuid];
}

void UserMgr::UpdateFriendList()
{

    QDir dir(".");
    dir.cdUp(); // 返回上级目录
    dir.cdUp(); // 再次返回上级目录
    QString jsonPath = dir.absoluteFilePath("statics/friendlist.json");
    // QString jsonPath = "D:\\code\\qt\\QChatter\\statics\\friendlist.json";
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

    if(jsonDoc.isArray()) {
        QJsonArray jsonArray = jsonDoc.array();
        QJsonArray new_objArray;
        for (const QJsonValue &value : jsonArray) {
            if (value.isObject()) {
                QJsonObject obj = value.toObject();
                QString uuid = obj["uuid"].toString();
                QString avatar = "statics/images/" + value["avatar"].toString();
                QString avatarPath = dir.absoluteFilePath(avatar);
                obj["avatar"] = avatarPath;
                _friendList[uuid] = obj;
                new_objArray.append(obj);

            }
        }
        QJsonDocument new_jsonDoc(new_objArray);

        QByteArray byteArray = new_jsonDoc.toJson();
        emit sig_update_friendlist_finish(byteArray);

    }
}
