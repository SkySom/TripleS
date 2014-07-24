module triples.message;

enum MessageType {
	RAW,
	PRIVMSG,
	JOIN,
	PART
}

struct Message {
	MessageType type;
	string from;
	string to;
	string message;
	Direction direction;
}

enum Direction {
	INCOMING,
	OUTGOING
}
