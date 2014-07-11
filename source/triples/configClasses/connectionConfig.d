module triples.configClasses.connectionConfig;

import std.conv;
import std.json;

import triples.configClasses.baseConfig;

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
