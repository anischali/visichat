#ifndef QCHAT_H
#define QCHAT_H

#include <QObject>
#include <QImage>
#include <QSharedDataPointer>
#include <cstdint>
#include <lite-p2p/peer_connection.hpp>
#include <lite-p2p/stun_client.hpp>
#include <lite-p2p/stun_session.hpp>
#include <lite-p2p/network.hpp>

struct peer_contact_t {
    char name[32];
    uint8_t user_id[32];
    struct sockaddr_t addr;
};

class QChat : public QObject
{
    Q_OBJECT
protected:
    lite_p2p::peer_connection *peer;
    struct stun_session_t s_stun;
    lite_p2p::stun_client *stun;
    qbackend::engines::qrcode_engine *qrcode;

    void gatherAddress();

public:
    explicit QChat(QObject *parent = 0);
    ~QChat();

    Q_INVOKABLE QString shareContact(int width, int height);
};

#endif // QCHAT_H
