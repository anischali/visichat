#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QScreen>
#include <QStandardPaths>
#include <settings.hpp>
#include <storage_engine.hpp>
#include <fmt/core.h>
#include <fmt/format.h>
#include <lite-p2p/peer/connection.hpp>
#include <lite-p2p/protocol/stun/client.hpp>
#include <lite-p2p/protocol/turn/client.hpp>
#include <lite-p2p/network/network.hpp>
#include <QQmlContext>
#include <QDebug>
#include "qchat.hpp"


using namespace qbackend::model;
using namespace qbackend::engines;

#define APP_NAME "visichat"
#define ORG_NAME "visibog"

void initialize_storage()
{
    std::string d_path = fmt::format("{}/{}", QStandardPaths::writableLocation(QStandardPaths::AppConfigLocation).toStdString(), ORG_NAME);
    if (!storage_engine::path_exist(d_path))
    {
        storage_engine::create_directory(d_path, true);
    }
}

void set_qt_environment()
{
    qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", "1");
    qputenv("QT_ENABLE_HIGHDPI_SCALING", "0");
    qputenv("QT_LOGGING_RULES", "qt.qml.connections=false");
    qputenv("QT_QUICK_CONTROLS_CONF", ":/resources/qtquickcontrols2.conf");
    qputenv("QML_COMPAT_RESOLVE_URLS_ON_ASSIGNMENT", "1");
}

uint32_t get_dpi_scale_factor(void)
{
    QScreen *s = QGuiApplication::primaryScreen();
    if (!s)
        return 1;
    float dpi = s->logicalDotsPerInch();
    if (dpi == 96.0)
        return 1;

    return std::ceil((dpi + 0.5) / 96.0) + 1;
}

void vprint(QQmlApplicationEngine *engine, std::string str) {
    engine->rootContext()->setContextProperty("console_message", str.c_str());
}

int main(int argc, char *argv[])
{
    srand(time(NULL));
    QStringList builtInStyles = { QString("CustomStyle"), QString("Basic"),
                                 QString("Material"), QString("Universal") };
    std::string console;

    std::string path = fmt::format("{}/{}", QStandardPaths::writableLocation(QStandardPaths::ConfigLocation).toStdString(), ORG_NAME);
    settings settings(path, APP_NAME);

restart:
    initialize_storage();
    qputenv("QT_SCALE_FACTOR", settings.get_value("scale_factor"));
    set_qt_environment();

    QGuiApplication app(argc, argv);
    QGuiApplication::setApplicationName(APP_NAME);
    QGuiApplication::setOrganizationName(ORG_NAME);


    if (settings.get_value("scale_factor").empty())
    {
        uint32_t factor = get_dpi_scale_factor();
        settings.set_value("scale_factor", std::to_string(factor));
        goto restart;
    }

    std::string output;

    if (qEnvironmentVariableIsEmpty("QT_QUICK_CONTROLS_STYLE") &&
        settings.get_value("style").empty()) {
        QString style;
#if defined(Q_OS_MACOS)
        style = QString("iOS");int main(int argc, const char *argv[]) {

            std::string out;
            web_engine::request(argv[1], "", &out);

            return 0;
        }
#elif defined(Q_OS_IOS)
        style = QString("iOS");
#elif defined(Q_OS_WINDOWS)
        style = QString("Windows");
#elif defined(Q_OS_ANDROID)
        style = QString("Material");
#elif defined(Q_OS_LINUX) || defined(Q_OS_UNIX)
        style = QString("Material");
#endif
        QQuickStyle::setStyle(style);
    } else {
        QQuickStyle::setStyle(QString::fromStdString(settings.get_value("style")));
    }

    const QString styleInSettings = QString::fromStdString(settings.get_value("style"));
    if (styleInSettings.isEmpty())
        settings.set_value("style", QQuickStyle::name().toStdString());

#if defined(Q_OS_MACOS)
    builtInStyles << QString("iOS");
#elif defined(Q_OS_IOS)
    builtInStyles << QString("iOS");
#elif defined(Q_OS_WINDOWS)
    builtInStyles << QString("Windows");
#endif

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);


    qmlRegisterType<QChat>("com.visibog.qchat", 1, 0, "QChat");

    engine.setInitialProperties({{ "builtInStyles", builtInStyles }});

    engine.loadFromModule("visichat", "MainWindow");

    return app.exec();
}
