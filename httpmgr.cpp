#include "httpmgr.h"
#include <QObject>
#include <QNetworkReply>
#include <QDebug>
HttpMgr::HttpMgr()
{
    //连接http请求和完成信号，信号槽机制保证队列消费
    connect(this, &HttpMgr::sig_http_finish, this, &HttpMgr::slot_http_finish);
}

HttpMgr::~HttpMgr() {
    std::cout << "this is httpMgr destruct" << std::endl;
}

void HttpMgr::PostHttpReq(QUrl url, QJsonObject json, Global::ReqId req_id, Global::Modules mod)
{
    //创建一个HTTP POST请求，并设置请求头和请求体
    QByteArray data = QJsonDocument(json).toJson();
    //通过url构造请求
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
    request.setHeader(QNetworkRequest::ContentLengthHeader, QByteArray::number(data.length()));
    //发送请求，并处理响应, 获取自己的智能指针，构造伪闭包并增加智能指针引用计数
    auto self = shared_from_this();
    QNetworkReply * reply = _manager.post(request, data);
    //设置信号和槽等待发送完成
    QObject::connect(reply, &QNetworkReply::finished, [reply, self, req_id, mod](){
        //处理错误的情况
        if(reply->error() != QNetworkReply::NoError){
            qDebug() << reply->errorString();
            //发送信号通知完成
            emit self->sig_http_finish(req_id, "", Global::ErrorCodes::ERR_NETWORK, mod);
            reply->deleteLater();
            return;
        }
        //无错误则读回请求
        QString res = reply->readAll();
        //发送信号通知完成
        emit self->sig_http_finish(req_id, res, Global::ErrorCodes::SUCCESS,mod);
        reply->deleteLater();
        return;
    });
}

void HttpMgr::PostHttpReq(const QString &url, const QVariantMap &map, Global::ReqId req_id, Global::Modules mod)
{
    QUrl uri = QUrl(url);
    QJsonObject json = QJsonObject::fromVariantMap(map);
    PostHttpReq(uri, json, req_id, mod); // 调用原始方法（如果需要，可以是私有的）

}

void HttpMgr::slot_http_finish(Global::ReqId id, QString res, Global::ErrorCodes err, Global::Modules mod)
{
    if(mod == Global::Modules::REGISTERMOD){
        //发送信号通知指定模块http响应结束
        emit sig_reg_mod_finish(id, res, err);
    }
}

void HttpMgr::print()
{
    qDebug() << "print";
}
