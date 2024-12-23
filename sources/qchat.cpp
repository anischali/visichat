#include "qchat.hpp"
#include "servers.hpp"
#include <QStandardPaths>
#include <cstdlib>
#include <QImage>
#include <QBuffer>
#include <QDebug>
#include <fmt/core.h>
#include <fmt/format.h>




QChat::QChat(QObject *parent) : QObject(parent) {

    peer = new lite_p2p::peer::connection(5002);
    stun = new lite_p2p::protocol::stun::client(peer->sock_fd);
    qrcode = new qbackend::engines::qrcode_engine();

    struct stun_server_t srv = stun_servers["google"];
    s_stun = {
        .user = srv.username,
        .software = "lite-p2p v 1.0",
        .realm = srv.realm,
        .key_algo = SHA_ALGO_MD5,
        .password_algo = SHA_ALGO_CLEAR,
        .hmac_algo = SHA_ALGO_SHA1,
        .lifetime = 3600,
        .protocol = IPPROTO_UDP,
        .family = INET_IPV4,
        .lt_cred_mech = true,
    };

    lite_p2p::network::resolve(&s_stun.server, AF_INET, srv.url, srv.port);
    stun->bind_request(&s_stun);
}


QChat::~QChat()
{
    peer->~connection();
    stun->~client();
    qrcode->~qrcode_engine();
}


QString QChat::shareContact(int width, int height) {

    struct peer_contact_t p;
    uint8_t data[sizeof(p)];
    QBuffer b_img;


    std::vector<uint8_t> uid = lite_p2p::crypto::crypto_random_password(256);
    memcpy(&p.user_id[0], uid.data(), std::min(sizeof(p.user_id), uid.size()));
    memcpy(&p.addr, &s_stun.mapped_addr, sizeof(p.addr));

    memcpy(&data[0], &p, sizeof(p));

    std::string epeer = lite_p2p::crypto::crypto_base64_encode(data, sizeof(data));

    ZXing::Matrix<uint8_t> bitmap = qrcode->write(epeer, ZXing::BarcodeFormat::QRCode, width, height);
    auto q_img = QImage(bitmap.data(), bitmap.width(), bitmap.height(), bitmap.width(), QImage::Format::Format_Grayscale8);
    q_img.save(&b_img, "PNG");

    return QString("data:image/png;base64," + QString(b_img.data().toBase64()));
}

QString QChat::imgToBase64(QImage q_img) {

    QBuffer b_img;

    q_img.save(&b_img, "PNG");

    return QString(b_img.data().toBase64());
}


QString QChat::importContact(QString b64_img, int x, int y, int width, int height) {
    QImage q_img, q_tmp;

    auto img_buf = lite_p2p::crypto::crypto_base64_decode(b64_img.toStdString().c_str(), b64_img.length());

    q_img.loadFromData(img_buf.data(), img_buf.size(), "PNG");

    q_tmp = q_img.copy(x, y, width, height);

    auto iv = ZXing::ImageView((uint8_t *)q_tmp.data_ptr(), q_tmp.width(), q_tmp.height(), ZXing::ImageFormat::RGB, 0, 0);

    auto pth = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/qr-code.png";
    q_tmp.save(pth, "PNG");

    return QString(qrcode->read(iv).c_str());
}
