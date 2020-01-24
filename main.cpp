#include <QGuiApplication>
#include <QQmlApplicationEngine>

//#include <QtCore/QStandardPaths>
//#include <QtCore/QString>
//#include <QtCore/QStringList>
//#include <QtQml/QQmlContext>
//#include <QtQml/QQmlEngine>
//#include <QtGui/QGuiApplication>
//#include <QtQuick/QQuickItem>
//#include <QtQuick/QQuickView>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));

//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    const QStringList moviesLocation = QStandardPaths::standardLocations(QStandardPaths::MoviesLocation);
//    const QUrl videoPath =
//            QUrl::fromLocalFile(moviesLocation.isEmpty() ?
//                                    app.applicationDirPath() :
//                                    moviesLocation.front());
//    engine.rootContext()->setContextProperty("source", videoPath);

    engine.load(url);

    return app.exec();
}
