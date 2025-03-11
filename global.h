// Global.h
#ifndef GLOBAL_H
#define GLOBAL_H

#include <QObject>

class Global : public QObject {
    Q_OBJECT

public:
    enum ReqId {
        ID_GET_VARIFY_CODE = 1001, // 获取验证码
        ID_REG_USER = 1002,       // 注册用户
    };
    Q_ENUM(ReqId)

    enum ErrorCodes {
        SUCCESS = 0,
        ERR_JSON = 1, // Json解析失败
        ERR_NETWORK = 2,
    };
    Q_ENUM(ErrorCodes)

    enum Modules {
        REGISTERMOD = 0,
    };
    Q_ENUM(Modules)
};

#endif // GLOBAL_H
