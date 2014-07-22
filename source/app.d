import std.stdio;

import triples.bot;
import triples.pluginmanager;

void main() {
	auto bot = new TripleS();
	auto pluginManager = new PluginManager();

	// TODO: Consider decoupling PluginManager and Bot
	bot.setPluginManager(pluginManager);
	pluginManager.setBot(bot);
}
