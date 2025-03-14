#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>
#include "framelesswindow.h"
#include "global.h"
#include "httpmgr.h"
/**
 * @brief 程序入口函数
 * 
 * 初始化Qt应用程序，设置窗口图标，注册QML类型
 * 并启动QML引擎加载主界面
 */
int main(int argc, char *argv[])
{
    // 创建Qt GUI应用程序实例
    QGuiApplication app(argc, argv);

    // 创建QML引擎实例
    QQmlApplicationEngine engine;

    // 设置应用程序窗口图标
    app.setWindowIcon(QIcon(":/src/images/logo.png"));

    // 注册HttpMgr单例到QML环境
    qmlRegisterSingletonType<HttpMgr>("io.httpmgr",
                                      1,
                                      0,
                                      "HttpMgr",
                                      [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
                                          Q_UNUSED(engine)
                                          Q_UNUSED(scriptEngine)
                                          return HttpMgr::GetInstance().get(); // 返回HttpMgr单例实例
                                      });

    // 注册Global类型到QML环境，使得枚举值可在QML中使用
    qmlRegisterType<Global>("io.global", 1, 0, "Global");

    // 注册FramelessWindow类型到QML环境，用于无边框窗口
    qmlRegisterType<FramelessWindow>("an.io", 1, 0, "FramelessWindow");

    // 连接QML引擎的对象创建失败信号，发生错误时退出应用
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    // 加载主QML模块
    engine.loadFromModule("QChatter", "Main");

    // 启动事件循环
    return app.exec();
}
