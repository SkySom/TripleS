module triples.pluginhandler;

import std.stdio;

import thrift.base;
import thrift.codegen.client;
import thrift.protocol.binary;
import thrift.transport.buffered;
import thrift.transport.socket;

import triples.thrift.message.message;

class PluginHandler {
  this() {
    auto socket = new TSocket("localhost", 9090);
    auto transport = new TBufferedTransport(socket);
    auto protocol = tBinaryProtocol(transport);
    auto client = tClient!message(protocol);

    transport.open();

    client.onMessage("something", "something", "something", "something");
  }
}
