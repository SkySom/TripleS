module triples.bot;

import std.array;
import std.stdio;
import std.socket;

import irc.client;
import irc.tracker;
import irc.eventloop;

import triples.pluginmanager;
import triples.configclasses.config;

class TripleS {
	Config config;
	PluginManager pluginManager;

	IrcClient client;
	IrcTracker tracker;
	IrcEventLoop eventloop;

	this() {
		client = new IrcClient();
		config = new Config();

		setClientDetails();
		clientConnect();
		tracker = track(client);
		tracker.start();

		foreach(string channel; config.channels) {
			client.join(channel);
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
	}

	public void shutdown() {
		eventloop.remove(client);
	}
}
