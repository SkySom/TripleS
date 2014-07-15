import std.stdio;

import vibe.d;

import triples.bot;

shared static this()
{
	auto routes = new URLRouter;
	auto settings = new HTTPServerSettings();
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];
	listenHTTP(settings, routes);
	
	auto triples = new TripleS();
}
