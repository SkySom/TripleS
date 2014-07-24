module triples.configclasses.config;

import std.stdio;
import std.conv;
import std.json;

import triples.configclasses.configutil;

class Config {
    string nickName;
    string realName;
    string userName;
    string[] channels;

    ushort port;
    char[] address;

    this() {
        this("config/config.json");
    }

    this(string fileLocation) {
        JSONValue config = ConfigUtil.loadConfig(fileLocation);

        JSONValue bot = config["bot"];
        nickName = bot["nickName"].str();
        realName = bot["realName"].str();
        userName = bot["userName"].str();
        channels = ConfigUtil.toStringArray(bot["channels"].array());

        JSONValue connection = config["connection"];
        port = to!ushort(connection["port"].str());
        address = ConfigUtil.toCharArray(connection["address"].str());
    }
}
