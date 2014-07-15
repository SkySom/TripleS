module triples.configclasses.connectionconfig;

import std.conv;
import std.json;

import triples.configclasses.baseconfig;

class ConnectionConfig : BaseConfig {
  ushort port;
  char[] address;

  this() {
    this("config/connectionConfig.json");
  }

  this(string fileLocation) {
    configLocation = fileLocation;
    JSONValue config = loadConfig();
    port = to!ushort(config["port"].str());
    address = toCharArray(config["address"].str());
  }
}
