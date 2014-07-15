/*
 * This auto-generated skeleton file illustrates how to build a server. If you
 * intend to customize it, you should edit a copy with another file name to
 * avoid overwriting it when running the generator again.
 */
module triples.thrift.message.message_server;

import std.stdio;
import thrift.codegen.processor;
import thrift.protocol.binary;
import thrift.server.simple;
import thrift.server.transport.socket;
import thrift.transport.buffered;
import thrift.util.hashset;

import triples.thrift.message.message;
import triples.thrift.message.message_types;


class messageHandler : message {
  this() {
    auto protocolFactory = new TBinaryProtocolFactory!();
    auto processor = new TServiceProcessor!message(new messageHandler);
    auto serverTransport = new TServerSocket(9090);
    auto transportFactory = new TBufferedTransportFactory;
    auto server = new TSimpleServer(
      processor, serverTransport, transportFactory, protocolFactory);
    server.serve();
  }

  void onMessage(string from, string to, string text, string message) {
    // Your implementation goes here.
    writeln("onMessage called");
  }

}
