module triples.logger;

import std.datetime;
import std.string;
import std.file;

class Logger {
    string fileLocation;

    this() {
        this("logs/log.log");
    }

    this(string path) {
        fileLocation = path;
        if(!path.exists()) {
            write(path, "");
        }
    }

    enum LogLevel : string {
        DEBUG = "DBUG",
        INFO = "INFO",
        WARNING = "WARN",
        ERROR = "ERRR",
        FATAL = "FATL"
    }

    void writeEntry(LogLevel level, string origin, string message) {
        SysTime time = Clock.currTime();
        time.fracSec(FracSec.zero());
        string log = "[" ~ time.toISOExtString() ~ "] [" ~ level
            ~ "] " ~ origin ~ ": " ~ message ~ "\n";
        append(fileLocation, log);
    }

    void logDebug(string origin, string message) {
        writeEntry(LogLevel.DEBUG, origin, message);
    }

    void logInfo(string origin, string message) {
        writeEntry(LogLevel.INFO, origin, message);
    }

    void logWarning(string origin, string message) {
        writeEntry(LogLevel.WARNING, origin, message);
    }

    void logError(string origin, string message) {
        writeEntry(LogLevel.ERROR, origin, message);
    }

    void logFatal(string origin, string message) {
        writeEntry(LogLevel.FATAL, origin, message);
    }
}
