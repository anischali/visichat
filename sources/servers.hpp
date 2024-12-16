#ifndef SERVERS_HPP
#define SERVERS_HPP


#include "lite-p2p/cleanup.hpp"
#include "lite-p2p/stun_client.hpp"
#include "lite-p2p/turn_client.hpp"
#include "lite-p2p/peer_connection.hpp"
#include "lite-p2p/network.hpp"
#include "lite-p2p/ice_agent.hpp"
#include "lite-p2p/stun_session.hpp"

std::map<std::string, struct stun_server_t> stun_servers = {
    {
        "localhost",
        {
            .type = STUN_SERV_TYPE_STUN_TURN,
            .port = 3478,
            .url = "192.168.0.10",
            .username = "visi",
            .credential = "/0X8VMBsdnlL5jWq5xu7ZA==",
            .realm = "visibog.org",
            .support_ipv6 = true,
        }
    },
    {
        "freestun",
        {
            .type = STUN_SERV_TYPE_STUN_TURN,
            .port = 3478,
            .url = "turn:freestun.net",
            .username = "free",
            .credential = "free",
            .realm = "freestun.net",
            .support_ipv6 = false,
        }
    },
    {
        "google",
        {
            .type = STUN_SERV_TYPE_STUN_ONLY,
            .port = 19302,
            .url = "stun:stun.l.google.com",
            .support_ipv6 = true,
        }
    },
};

#endif // SERVERS_HPP
