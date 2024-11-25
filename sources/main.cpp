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
#include <lite-p2p/peer_connection.hpp>
#include <lite-p2p/stun_client.hpp>
#include <lite-p2p/network.hpp>
#include <QQmlContext>
#include<QDebug>


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

int main(int argc, char *argv[])
{
    QStringList builtInStyles = { QString("CustomStyle"), QString("Basic"),
                                 QString("Material"), QString("Universal") };
    std::string console;

    std::string path = fmt::format("{}/{}", QStandardPaths::writableLocation(QStandardPaths::ConfigLocation).toStdString(), ORG_NAME);
    settings settings(path, APP_NAME);
    lite_p2p::peer_connection peer(5002);
    lite_p2p::stun_client stun(peer.sock_fd);
    std::vector<lite_p2p::network> ifaces_info;


    auto ifaces = lite_p2p::network::net_interfaces();
    for (int i = 0; i < ifaces.size(); ++i) {
        if (ifaces[i] != "lo") {
            lite_p2p::network iface(ifaces[i]);
            ifaces_info.push_back(iface);
            console += iface.to_string().c_str();
        }
    }

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
    int ret = stun.request("34.203.251.243", 3478);
    //web_engine::request("https://ipv4.icanhazip.com", "/", &output);

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

    std::string s = inet_ntoa(stun.ext_ip.sin_addr);

    console += "ext_ip: ";
    console += s.c_str();
    console += "ext_port: ";
    console += std::to_string(stun.ext_ip.sin_port);

    engine.rootContext()->setContextProperty("screenConsole", console.c_str());

    engine.setInitialProperties({{ "builtInStyles", builtInStyles }});

    engine.loadFromModule("visichat", "MainWindow");

    return app.exec();
}
