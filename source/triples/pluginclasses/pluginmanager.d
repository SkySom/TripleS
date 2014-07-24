module triples.pluginclasses.pluginmanager;

import triples.bot;
import triples.message;
import triples.permissions.permission;
import triples.pluginclasses.plugin;

class PluginManager {
	TripleS bot;
	Plugin[] plugins;

	this() {
		// TODO: Load plugins from config?
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
}
