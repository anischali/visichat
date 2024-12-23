#ifndef QCHAT_H
#define QCHAT_H

#include <QObject>
#include <QImage>
#include <QSharedDataPointer>
#include <cstdint>
#include <lite-p2p/peer/connection.hpp>
#include <lite-p2p/protocol/stun/client.hpp>
#include <lite-p2p/protocol/stun/session.hpp>
#include <lite-p2p/network/network.hpp>

struct peer_contact_t {
    char name[32];
    uint8_t user_id[32];
    struct sockaddr_t addr;
};

class QChat : public QObject
{
    Q_OBJECT
protected:
    lite_p2p::peer::connection *peer;
    struct stun_session_t s_stun;
    lite_p2p::protocol::stun::client *stun;
    qbackend::engines::qrcode_engine *qrcode;

    void gatherAddress();

public:
    explicit QChat(QObject *parent = 0);
    ~QChat();

    Q_INVOKABLE QString shareContact(int width, int height);
    Q_INVOKABLE QString importContact(QString b64_img,
                    int x, int y, int width, int height);
    Q_INVOKABLE QString imgToBase64(QImage q_img);
};

#endif // QCHAT_H
