module triples.messagehandlers;

import std.conv;
import std.traits;
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

    enum Handlers {
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
        onCtcpQuery,
        onCtcpReply,
	    onNickInUse,
        onTopic,
        onTopicInfo,
        onUserhostReply,
	    onWhoisReply,
	    onWhoisServerReply,
	    onWhoisOperatorReply,
	    onWhoisIdleReply,
	    onWhoisChannelsReply,
	    onWhoisAccountReply,
	    onWhoisEnd
    };

    IrcClient setMessageHandlers(IrcClient client) {
        foreach (immutable handler; EnumMembers!Handlers) {
            mixin("client." ~ to!string(handler)) ~= &(__traits(getMember, this, to!string(handler)));
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

    void onCtcpReply(IrcUser user, in char[] source, in char[] tag, in char[] data) {

    }

    const(char)[] onNickInUse(in char[] newNick) {
        return newNick ~ "_";
    }

    void onTopic(in char[] channel, in char[] topic) {

    }

    void onTopicInfo(in char[] channel, in char[] nick, in char[] time) {

    }

    void onUserhostReply(in IrcUser[] users) {

    }

    void onWhoisReply(IrcUser userInfo, in char[] realName) {

    }

    void onWhoisServerReply(in char[] nick, in char[] serverHostName, in char[] serverInfo) {

    }

    void onWhoisOperatorReply(in char[] nick) {

    }

    void onWhoisIdleReply(in char[] nick, int idleTime) {

    }

    void onWhoisChannelsReply(in char[] nick, in char[][] channels) {

    }

    void onWhoisAccountReply(in char[] nick, in char[] accountName) {

    }

    void onWhoisEnd(in char[] nick) {

    }
}
