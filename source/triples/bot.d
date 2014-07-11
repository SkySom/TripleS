module triples.bot;

import std.stdio;
import std.socket;

import irc.client;
import irc.eventloop;


class TripleS {
  this() {
    writeln("Starting");
    auto client = new IrcClient();
    auto ircAddress = new InternetAddress("", 0000);
    client.realName = "";
    client.userName = "";
    client.nickName = "";
    client.connect(ircAddress);
    client.join("");
    writeln(client.connected());
    auto eventloop = new IrcEventLoop();
    eventloop.add(client);
    eventloop.run();
  }


}
