module triples.bot;

import std.stdio;
import std.socket : Socket;

import irc.client;
import irc.eventloop;


class TripleS {
  this() {
    writeln("Starting TripleS");
    auto connection = new IrcClient();
    auto ircAddress = new InternetAddress("irc.freenode.net", 6667);
    connection.connect(ircAddress);
    auto eventloop = new IrcEventLoop();
    eventloop.add(connection);
  }


}
