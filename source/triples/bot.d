module triples.bot;

import std.array;
import std.conv;
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

    client.onMessage ~= &onMessage;

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

	void shutdown() {
		eventloop.remove(client);
	}

  void onMessage(IrcUser user, in char[] target, in char[] message) {
    string infomessage = to!string(user.nickName ~ " has said \"" ~ message ~
      "\" to " ~ target);
    logger.info("Bot", infomessage);
  }
}
