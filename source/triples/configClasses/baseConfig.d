module triples.configclasses.baseconfig;

import std.array;
import std.file;
import std.json;
import std.stdio;

abstract class BaseConfig {
  string configLocation;

  JSONValue loadConfig() {
    string fileString = readText(configLocation);
    JSONValue configJson = parseJSON(fileString);
    return configJson;
  }

  //This seems hacky... But it works. So... for now.
  string[] toStringArray(JSONValue[] jsonArray) {
    string[] stringArray = new string[jsonArray.length];
    for(int x; x < jsonArray.length; x++) {
      stringArray[x] = jsonArray[x].str();
    }
    return stringArray;
  }

  //Same thing.
  char[] toCharArray(string theString) {
    auto charArray = appender!string();
    charArray.put(theString);
    return charArray.data;
  }
}
