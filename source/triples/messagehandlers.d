module triples.messagehandlers;

import std.conv;

import irc.client;

import triples.logger;
import triples.message;

class MessageHandler {
    Logger logger;

    this() {
        logger = new Logger("logs/messagehandler.log");
    }

    this(Logger log) {
        logger = log;
    }

    IrcClient setMessageHandlers(IrcClient client) {
        client.onMessage ~= &onMessage;
        client.onConnect ~= &onConnect;
        return client;
    }

    void onConnect() {
        logger.logInfo("Bot", "Has successfully connected");
    }

    void onMessage(IrcUser user, in char[] target, in char[] message) {
        string infomessage = to!string(user.nickName ~ " has said \"" ~ message ~
            "\" to " ~ target);
        logger.logInfo("Bot", infomessage);
    }
}
