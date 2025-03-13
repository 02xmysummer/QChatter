// Global.h
#ifndef GLOBAL_H
#define GLOBAL_H

#include <QObject>

/**
 * @brief 全局常量和枚举定义类
 * 
 * 该类定义了整个应用程序中使用的全局常量、枚举和错误码
 * 继承自QObject以支持在QML中使用这些枚举值
 */
class Global : public QObject
{
    Q_OBJECT

public:
    /**
     * @brief 请求ID枚举
     * 用于标识不同类型的HTTP请求
     */
    enum ReqId {
        ID_GET_VARIFY_CODE = 1001,  ///< 获取验证码的请求ID
        ID_REG_USER = 1002,         ///< 注册用户的请求ID
    };
    Q_ENUM(ReqId)  // 使枚举在QML中可用

    /**
     * @brief 错误码枚举
     * 定义了系统中可能出现的各种错误类型
     */
    enum ErrorCodes {
        SUCCESS = 0,     ///< 操作成功
        ERR_JSON = 1,    ///< JSON解析失败
        ERR_NETWORK = 2, ///< 网络错误
    };
    Q_ENUM(ErrorCodes)  // 使枚举在QML中可用

    /**
     * @brief 模块枚举
     * 定义了系统中的不同功能模块
     */
    enum Modules {
        REGISTERMOD = 0,  ///< 注册模块
    };
    Q_ENUM(Modules)  // 使枚举在QML中可用
};

#endif // GLOBAL_H
