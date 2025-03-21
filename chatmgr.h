#ifndef CHATMGR_H
#define CHATMGR_H

#include <QJsonObject>
#include <QMap>
#include <QObject>
#include <QJsonArray>
#include "Singleton.h"
class ChatMgr : public QObject,
                public Singleton<ChatMgr>,
                public std::enable_shared_from_this<ChatMgr>
{
    Q_OBJECT
public:
    explicit ChatMgr(QObject *parent = nullptr);

    Q_INVOKABLE void UpdateChatList();

    Q_INVOKABLE void GetChatHistory(const QString &uuid);
    void ClearOldCache(); // 清理旧的缓存

    Q_INVOKABLE void RemoveChat(const QString &uuid);
    bool deleteChat(const QString &uuid);

    Q_INVOKABLE void CreateChat(const QString &uuid);


    Q_INVOKABLE void SendMessage(const QString &uuid,const QString &message);

signals:
    void sig_update_chatlist_finish(QByteArray res);
    void sig_get_chathistory_finish(QByteArray res);
    void sig_switch_curchat_finish(QString uuid);
    void sig_create_chat_finish(QByteArray res);


private:
    QMap<QString, QJsonObject> _chatList;
    QMap<QString, QJsonObject> _recentHistoryCache;
    static const int MAX_CACHE_SIZE = 20;

    QString _chatListPath;
};

#endif // CHATMGR_H
