#ifndef HTTPMGR_H
#define HTTPMGR_H

#include <QObject>
#include "singleton.h"
#include "global.h"
#include <QUrl>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QJsonDocument>
class HttpMgr :public QObject, public Singleton<HttpMgr>,
                public std::enable_shared_from_this<HttpMgr>
{
    Q_OBJECT
public:
    ~HttpMgr();
    Q_INVOKABLE void PostHttpReq(QUrl url, QJsonObject json, Global::ReqId req_id, Global::Modules mod);
    Q_INVOKABLE void PostHttpReq(const QString &url, const QVariantMap &map, Global::ReqId req_id, Global::Modules mod);
    void slot_http_finish(Global::ReqId id, QString res, Global::ErrorCodes err, Global::Modules mod);
    Q_INVOKABLE void print();
signals:
    void sig_http_finish(Global::ReqId id, QString res, Global::ErrorCodes err, Global::Modules mod);
    void sig_reg_mod_finish(Global::ReqId id, QString res, Global::ErrorCodes err);
private:
    friend class Singleton<HttpMgr>;
    HttpMgr();
    QNetworkAccessManager _manager;
};

#endif // HTTPMGR_H
