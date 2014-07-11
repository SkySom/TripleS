module triples.configClasses.botConfig;

import std.json;

import triples.configClasses.baseConfig;

class BotConfig : BaseConfig {
  string nickName;
  string realName;
  string userName;
  string[] channels;

  this() {
    this("config/botConfig.json");
  }

  this(string fileLocation) {
    configLocation = fileLocation;
    JSONValue config = loadConfig();
    nickName = config["nickName"].str();
    realName = config["realName"].str();
    userName = config["userName"].str();
    channels = toStringArray(config["channels"].array());
  }
}
