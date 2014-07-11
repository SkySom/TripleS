module triples.bot;

import std.array;
import std.stdio;
import std.socket;

import irc.client;
import irc.eventloop;

import triples.configClasses.connectionConfig;
import triples.configClasses.botConfig;

class TripleS {
  ConnectionConfig connectConf;
  BotConfig botConf;

  this() {
    writeln("Starting");
    auto client = new IrcClient();

    connectConf = new ConnectionConfig();
    auto ircAddress = getAddress(connectConf.address, connectConf.port);

    botConf = new BotConfig();
    client.realName = botConf.realName;
    client.userName = botConf.userName;
    client.nickName = botConf.nickName;
    client.connect(ircAddress.front);

    foreach(string channel; botConf.channels) {
      client.join(channel);
    }

    auto eventloop = new IrcEventLoop();
    eventloop.add(client);
    eventloop.run();
  }
}
