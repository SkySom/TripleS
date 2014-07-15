module triples.bot;

import std.array;
import std.stdio;
import std.socket;

import irc.client;
import irc.tracker;
import irc.eventloop;

import triples.configclasses.connectionconfig;
import triples.configclasses.botconfig;
import triples.pluginhandler;
import triples.thrift.message.message_server;

class TripleS {
  ConnectionConfig connectConf;
  BotConfig botConf;
  PluginHandler pluginHandler;

  IrcClient client;
  IrcTracker tracker;

  this() {
    client = new IrcClient();
    connectConf = new ConnectionConfig();
    botConf = new BotConfig();
    pluginHandler = new PluginHandler();

    setClientDetails();
    clientConnect();
    tracker = new IrcTracker(client);

    foreach(string channel; botConf.channels) {
      client.join(channel);
    }

    auto eventloop = new IrcEventLoop();
    eventloop.add(client);
    eventloop.run();
  }

  void setClientDetails() {
    client.realName = botConf.realName;
    client.userName = botConf.userName;
    client.nickName = botConf.nickName;
  }

  void clientConnect() {
    auto ircAddress = getAddress(connectConf.address, connectConf.port);
    client.connect(ircAddress.front);
  }
}
