#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "httpmgr.h"
#include "global.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterSingletonType<HttpMgr>("com.example.singletons", 1, 0, "HttpMgr",
                                      [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject* {
                                          Q_UNUSED(engine)
                                          Q_UNUSED(scriptEngine)
                                          return HttpMgr::GetInstance().get(); // 假设您的单例有一个 getInstance() 静态方法
                                      });
    qmlRegisterType<Global>("com.example.global", 1, 0, "Global");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("QChatter", "Main");

    return app.exec();
}
