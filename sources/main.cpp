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
#include <lite-p2p/turn_client.hpp>
#include <lite-p2p/network.hpp>
#include <QQmlContext>
#include <thread>
#include <QDebug>


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
/*
int start_chat(int argc, const char *argv[]) {
        if (argc < 5) {
            printf("wrong arguments number !\n");
            exit(0);
        }

        srand(time(NULL));
        int family = atoi(argv[1]) == 6 ? AF_INET6 : AF_INET;
        lite_p2p::peer_connection conn(family, atoi(argv[4]));
        lite_p2p::turn_client turn(conn.sock_fd);
        struct stun_session_t s_turn = {
        .user = "free",
        .software = "lite-p2p v 1.0",
        .realm = "freestun.net",
        .lifetime = 60,
        .protocol = IPPROTO_UDP,
        .family = family,
    };

        struct stun_session_t s_turn = {
            .user = "visi",
            .software = "lite-p2p v 1.0",
            .realm = "visibog.org",
            .key_algo = SHA_ALGO_MD5,
            .password_algo = SHA_ALGO_CLEAR,
            .hmac_algo = SHA_ALGO_SHA1,
            .lifetime = 60,
            .protocol = IPPROTO_UDP,
            .family = family == AF_INET6 ? INET_IPV6 : INET_IPV4,
            .lt_cred_mech = true,
        };
        session_config c;
        lite_p2p::network::resolve(&s_turn.server, family, argv[2], atoi(argv[3]));

        c.stun_generate_key(&s_turn, "/0X8VMBsdnlL5jWq5xu7ZA==");

        c.stun_register_session(&s_turn);

        lite_p2p::network::string_to_addr(family, argv[6], &conn.remote);
        lite_p2p::network::set_port(&conn.remote, atoi(argv[5]));

        int ret = turn.allocate_request(&s_turn);
        if (ret < 0) {
            printf("request failed with: %d\n", ret);
            exit(-1);
        }

        ret = turn.create_permission_request(&s_turn, &conn.remote);
        ret = turn.bind_channel_request(&s_turn, &conn.remote, htons(rand_int(0x4000,0x4FFF)));
        ret = turn.refresh_request(&s_turn, s_turn.lifetime);
        //ret = turn.send_request_data(&s_turn, &conn.remote, s_buf);

        printf("mapped addr: %s:%d relayed addr: %s:%d\n",
               lite_p2p::network::addr_to_string(&s_turn.mapped_addr).c_str(),
               lite_p2p::network::get_port(&s_turn.mapped_addr),
               lite_p2p::network::addr_to_string(&s_turn.relayed_addr).c_str(),
               lite_p2p::network::get_port(&s_turn.relayed_addr));


        printf("bind: %s [%d]\n", lite_p2p::network::addr_to_string(&conn.local).c_str(), lite_p2p::network::get_port(&conn.local));
        printf("peer: %s [%d]\n", lite_p2p::network::addr_to_string(&conn.remote).c_str(), lite_p2p::network::get_port(&conn.remote));

        std::thread recver(visichat_listener, &conn);
        std::thread sender(visichat_sender, &conn);

        recver.join();
        sender.join();

        return 0;
}

*/
int main(int argc, char *argv[])
{
    srand(time(NULL));
    QStringList builtInStyles = { QString("CustomStyle"), QString("Basic"),
                                 QString("Material"), QString("Universal") };
    std::string console;

    std::string path = fmt::format("{}/{}", QStandardPaths::writableLocation(QStandardPaths::ConfigLocation).toStdString(), ORG_NAME);
    settings settings(path, APP_NAME);
    lite_p2p::peer_connection peer(5002);
    lite_p2p::stun_client stun(peer.sock_fd);
    std::vector<lite_p2p::network> ifaces_info;


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


    engine.setInitialProperties({{ "builtInStyles", builtInStyles }});

    engine.loadFromModule("visichat", "MainWindow");

    return app.exec();
}
