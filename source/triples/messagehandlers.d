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
        onMessage,
        onNotice,
        onNickChange,
        onSuccessfulJoin,
        onJoin,
        onPart,
        onQuit,
        onKick,
        onNameList,
        onNameListEnd,
        onCtcpQuery
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

    void onNotice(IrcUser user, in char[] target, in char[] message) {
        string infomessage = to!string(user.nickName ~ " has said \"" ~ message ~
            "\" to " ~ target);
        logger.logInfo("Bot", infomessage);
    }

    void onNickChange(IrcUser user, in char[] newNick) {

    }

    void onSuccessfulJoin(in char[] channel) {

    }

    void onJoin(IrcUser user, in char[] channel) {

    }

    void onPart(IrcUser user, in char[] channel) {

    }

    void onQuit(IrcUser user, in char[] comment) {

    }

    void onKick(IrcUser kicker, in char[] channel, in char[] kickedNick, in char[] comment) {

    }

    void onNameList(in char[] channel, in char[][] nickNames) {

    }

    void onNameListEnd(in char[] channel) {

    }

    void onCtcpQuery(IrcUser user, in char[] source, in char[] tag, in char[] data) {

    }
}
