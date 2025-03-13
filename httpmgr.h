#ifndef HTTPMGR_H
#define HTTPMGR_H

#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QObject>
#include <QUrl>
#include "global.h"
#include "singleton.h"

/**
 * @brief HTTP管理器类
 * 
 * 该类负责处理所有HTTP请求，实现了单例模式
 * 继承自QObject以支持Qt信号槽机制
 * 继承自Singleton模板类实现单例模式
 * 继承自enable_shared_from_this以支持共享指针的安全使用
 */
class HttpMgr : public QObject,
                public Singleton<HttpMgr>,
                public std::enable_shared_from_this<HttpMgr>
{
    Q_OBJECT
public:
    ~HttpMgr();

    /**
     * @brief 发送HTTP POST请求（QUrl和QJsonObject参数版本）
     * @param url 目标URL
     * @param json 请求体JSON数据
     * @param req_id 请求ID，用于标识不同的请求类型
     * @param mod 模块标识，指示请求来自哪个模块
     */
    Q_INVOKABLE void PostHttpReq(QUrl url,
                                 QJsonObject json,
                                 Global::ReqId req_id,
                                 Global::Modules mod);

    /**
     * @brief 发送HTTP POST请求（QString和QVariantMap参数版本）
     * @param url 目标URL字符串
     * @param map 请求参数映射
     * @param req_id 请求ID
     * @param mod 模块标识
     */
    Q_INVOKABLE void PostHttpReq(const QString &url,
                                 const QVariantMap &map,
                                 Global::ReqId req_id,
                                 Global::Modules mod);

    /**
     * @brief HTTP请求完成的槽函数
     * @param id 请求ID
     * @param res 响应结果
     * @param err 错误代码
     * @param mod 模块标识
     */
    void slot_http_finish(Global::ReqId id,
                          QString res,
                          Global::ErrorCodes err,
                          Global::Modules mod);

    /**
     * @brief 用于调试的打印函数
     */
    Q_INVOKABLE void print();

signals:
    /**
     * @brief HTTP请求完成信号
     * 当HTTP请求完成时发出，携带请求结果信息
     */
    void sig_http_finish(Global::ReqId id, QString res, Global::ErrorCodes err, Global::Modules mod);

    /**
     * @brief 注册模块完成信号
     * 专门用于处理注册模块的请求完成事件
     */
    void sig_reg_mod_finish(Global::ReqId id, QString res, Global::ErrorCodes err);

private:
    friend class Singleton<HttpMgr>;  // 允许Singleton访问私有构造函数
    HttpMgr();                        // 私有构造函数，确保单例模式
    QNetworkAccessManager _manager;    // Qt网络访问管理器实例
};

#endif // HTTPMGR_H
