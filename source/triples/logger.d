module triples.botlogger;

import std.file;
import std.exception;
import std.logger.filelogger;

class BotLogger {
  static FileLogger fileLogger;

  static instantiate() {
    if(!"logs/bot.log".exists()) {
      write("logs/bot.log", "");
    }
    fileLogger = new FileLogger("logs/bot.log", "botlogger");
  }

  static FileLogger getLogger() {
    nullCheck();
    return fileLogger;
  }

  static void log(string logMessage) {
    fileLogger.log(logMessage);
  }

  static void nullCheck() {
    if(fileLogger is null) {
      instantiate();
    }
  }
}
