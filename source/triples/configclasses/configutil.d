module triples.configclasses.configutil;

import std.array;
import std.file;
import std.json;
import std.stdio;

class ConfigUtil {

  static JSONValue loadConfig(string configLocation) {
    string fileString = readText(configLocation);
    JSONValue configJson = parseJSON(fileString);
    return configJson;
  }

  //This seems hacky... But it works. So... for now.
  static string[] toStringArray(JSONValue[] jsonArray) {
    string[] stringArray = new string[jsonArray.length];
    for(int x; x < jsonArray.length; x++) {
      stringArray[x] = jsonArray[x].str();
    }
    return stringArray;
  }

  //Same thing.
  static char[] toCharArray(string theString) {
    auto charArray = appender!string();
    charArray.put(theString);
    return charArray.data;
  }
}
