import std.stdio;
import core.atomic;
import core.sync.condition;
import core.sync.mutex;
import core.stdc.stdlib;
import core.thread;

import vibe.d;

import triples.bot;

shared static this()
{
	auto routes = new URLRouter;
	auto settings = new HTTPServerSettings();
	settings.port = 8080;
	settings.bindAddresses = ["::1", "127.0.0.1"];
	listenHTTP(settings, routes);

  TripleS triples = new TripleS();

	version(Windows){
		import core.stdc.signal;
		// WORKAROUND: we don't care about viral @nogc attribute here!
		import std.traits;
		signal(SIGABRT, cast(ParameterTypeTuple!signal[1])&onSignal);
		signal(SIGTERM, cast(ParameterTypeTuple!signal[1])&onSignal);
		signal(SIGINT, cast(ParameterTypeTuple!signal[1])&onSignal);
	}
}

private extern(C) void onSignal(int signal)
nothrow {
	logInfo("Received signal %d. I am shutting down.", signal);
}
