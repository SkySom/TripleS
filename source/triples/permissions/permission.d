module triples.permissions.permission;

import triples.message;

// TODO: Implement a few permissions.
interface Permission {
	// Return if the given message would be allowed under this permission.
	bool hasPermission(Message message);
}
