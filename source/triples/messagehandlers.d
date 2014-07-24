module triples.messagehandlers;

import std.conv;
import std.typetuple;

import irc.client;

import triples.logger;
import triples.message;
import triples.pluginclasses.pluginmanager;

class MessageHandler {
    Logger logger;
    PluginManager pluginManager;

    this() {
        logger = new Logger("logs/messagehandler.log");
    }

    this(Logger logger) {
        this.logger = logger;
    }

    void setPluginManager(PluginManager pluginManager) {
        this.pluginManager = pluginManager;
    }

    // Used from:
    // https://github.com/JakobOvrum/Dirk/blob/master/irc/tracker.d#L306
    alias Handlers = TypeTuple!(
		onConnect,
        onMessage
	);

    IrcClient setMessageHandlers(IrcClient client) {
        // Used from:
        // https://github.com/JakobOvrum/Dirk/blob/master/irc/tracker.d#L350
        foreach(handler; Handlers) {
			mixin("client." ~ __traits(identifier, handler)) ~= &handler;
        }
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
