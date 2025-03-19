#ifndef CHATMGR_H
#define CHATMGR_H

#include <QObject>
#include "Singleton.h"
#include <QMap>
#include <QJsonObject>
class ChatMgr : public QObject,
                public Singleton<ChatMgr>,
                public std::enable_shared_from_this<ChatMgr>
{
    Q_OBJECT
public:
    explicit ChatMgr(QObject *parent = nullptr);


    Q_INVOKABLE void UpdateChatList();
signals:
    void sig_update_chatlist_finish(QByteArray res);
private:
    QMap<QString, QJsonObject> _chatList;
    QMap<QString, QJsonObject> _chatHistory;
};

#endif // CHATMGR_H
