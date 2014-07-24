module triples.pluginclasses.plugin;

import std.container;

import triples.message;
import triples.permissions.permission;

class Plugin {
	string name;
	string host;
	string key;
	Permission[] permissions;
	DList!Message outgoingQueue;
	bool enabled = true;

	this(string name, string host, string key, Permission[] permissions) {
		this.name = name;
		this.host = host;
		this.key = key;
		this.permissions = permissions;
	}

	void setEnabled(bool enabled) {
		this.enabled = enabled;
	}

	Message getNextMessage() {
		Message next = outgoingQueue.front();
		outgoingQueue.removeFront();
		return next;
	}

	void addMessage(Message message) {
		outgoingQueue.insertBack(message);
	}

	Permission[] getPermissions() {
		return permissions;
	}
}
