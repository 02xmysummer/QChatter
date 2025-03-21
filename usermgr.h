#ifndef USERMGR_H
#define USERMGR_H

#include <QJsonObject>
#include <QMap>
#include <QObject>
#include "Singleton.h"
class UserInfo;
class UserMgr : public QObject,
                public Singleton<UserMgr>,
                public std::enable_shared_from_this<UserMgr>
{
    Q_OBJECT
public:
    explicit UserMgr(QObject *parent = nullptr);
    /**
     * @brief 获取指定用户信息
     * @param username 用户名
     */
    Q_INVOKABLE QJsonObject GetUserInfo(const QString &uuid);
    /**
     * @brief 更新好友列表
     */
    Q_INVOKABLE void UpdateFriendList();

    Q_INVOKABLE QJsonObject GetSelfInfo();

signals:
    void sig_update_friendlist_finish(QByteArray res);

private:
    std::map<QString, QJsonObject> _friendList;

    QJsonObject _self;
};

#endif // USERMGR_H
