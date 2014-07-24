module triples.bot;

import std.array;
import std.conv;
import std.stdio;
import std.socket;

import irc.client;
import irc.tracker;
import irc.eventloop;

import triples.logger;
import triples.messagehandlers;
import triples.configclasses.config;
import triples.pluginclasses.pluginmanager;

class TripleS {
	Config config;
	PluginManager pluginManager;
	MessageHandler messageHandler;
	Logger logger;

	IrcClient client;
	IrcTracker tracker;
	IrcEventLoop eventloop;

	this() {
		client = new IrcClient();
		config = new Config();
		logger = new Logger("logs/bot.log");
		messageHandler = new MessageHandler(logger);

		setClientDetails();
		setClientMessageHandlers();
		clientConnect();
		tracker = track(client);
		tracker.start();

		foreach(string channel; config.channels) {
			client.join(channel);
    		logger.logInfo("Bot", "has joined " ~ channel);
		}

		// TODO: Pass messages into pluginManager.onMessage()
		eventloop = new IrcEventLoop();
		eventloop.add(client);
		eventloop.run();
	}

	void setPluginManager(PluginManager pluginManager) {
		this.pluginManager = pluginManager;
	}

	void setClientDetails() {
		client.realName = config.realName;
		client.userName = config.userName;
		client.nickName = config.nickName;
	}

	void setClientMessageHandlers() {
		client = messageHandler.setMessageHandlers(client);
	}

	void clientConnect() {
		auto ircAddress = getAddress(config.address, config.port);
		client.connect(ircAddress.front);
	}

	void shutdown() {
		eventloop.remove(client);
	}
}
