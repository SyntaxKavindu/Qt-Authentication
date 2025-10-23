#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QObject>
#include "LoginAuthentication.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    LoginAuthentication loginAuthentication{&app};
    qmlRegisterSingletonInstance("Authentication",1,0,"Auth",&loginAuthentication);

    const QUrl url(QStringLiteral("qrc:/Qml/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
