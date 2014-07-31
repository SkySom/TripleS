module triples.pluginclasses.pluginmanager;

import std.stdio;

import stalkd;
import irc.client;

import triples.bot;
import triples.message;
import triples.permissions.permission;
import triples.pluginclasses.plugin;

class PluginManager {
	TripleS bot;
	Plugin[] plugins;
	Server server;

	this() {
		server = new Server("skylarsom.com");
		// TODO: Load plugins from config?
	}

	void start() {
		recieveMessage();
	}

	void setBot(TripleS bot) {
		this.bot = bot;
	}

	void onMessage(Message message) {
		foreach (int i, Plugin plugin; plugins) {
			bool send = false;
			foreach (int t, Permission permission; plugin.getPermissions()) {
				if (permission.hasPermission(message)) {
					send = true;
					break;
				}
			}
			if (send) {
				plugin.addMessage(message);
			}
		}
	}

	void recieveMessage() {
		auto tube = server.getTube("TripleS");
		bot.client.send("##TripleSTest", "Testing");
		while (true) {
			Job job = tube.reserve();
			bot.client.send("##TripleSTest", job.bodyAsString());
			job.destroy();
		}
	}
}
