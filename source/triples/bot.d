module triples.bot;

import std.array;
import std.logger;
import std.stdio;
import std.socket;

import irc.client;
import irc.tracker;
import irc.eventloop;

import triples.configclasses.config;
import triples.botlogger;
import triples.pluginhandler;

class TripleS {
  Config config;

  FileLogger fileLogger;

  IrcClient client;
  IrcTracker tracker;
  IrcEventLoop eventloop;

  this() {
    client = new IrcClient();
    config = new Config();
    fileLogger = BotLogger.getLogger();

    setClientDetails();
    clientConnect();
    tracker = track(client);
    tracker.start();

    foreach(string channel; config.channels) {
      client.join(channel);
      BotLogger.log(channel);
    }

    eventloop = new IrcEventLoop();
    eventloop.add(client);
    eventloop.run();
  }

  void setClientDetails() {
    client.realName = config.realName;
    client.userName = config.userName;
    client.nickName = config.nickName;
  }

  void clientConnect() {
    auto ircAddress = getAddress(config.address, config.port);
    client.connect(ircAddress.front);
  }

  public void shutdown() {
    eventloop.remove(client);
  }
}
