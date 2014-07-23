module triples.bot;

import std.array;
import std.stdio;
import std.socket;

import irc.client;
import irc.tracker;
import irc.eventloop;

import triples.pluginmanager;
import triples.logger;
import triples.configclasses.config;

class TripleS {
	Config config;
	PluginManager pluginManager;
  Logger logger;

	IrcClient client;
	IrcTracker tracker;
	IrcEventLoop eventloop;

	this() {
		client = new IrcClient();
		config = new Config();
    logger = new Logger("logs/bot.log");

		setClientDetails();
		clientConnect();
		tracker = track(client);
		tracker.start();

		foreach(string channel; config.channels) {
			client.join(channel);
      logger.info("Bot", "has joined " ~ channel);
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

	void clientConnect() {
		auto ircAddress = getAddress(config.address, config.port);
		client.connect(ircAddress.front);
    logger.info("Bot", "has connected to irc network");
	}

	public void shutdown() {
		eventloop.remove(client);
	}
}
