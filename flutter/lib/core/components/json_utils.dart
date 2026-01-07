/// JSON utility functions for working with component properties.

/// Gets a required string from a JSON object.
String getString(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) {
    throw ArgumentError('Required key "$key" not found');
  }
  return value.toString();
}

/// Gets an optional string from a JSON object.
String optString(Map<String, dynamic> json, String key, [String defaultValue = '']) {
  final value = json[key];
  if (value == null) return defaultValue;
  return value.toString();
}

/// Gets a required boolean from a JSON object.
bool getBoolean(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) {
    throw ArgumentError('Required key "$key" not found');
  }
  if (value is bool) return value;
  return value.toString().toLowerCase() == 'true';
}

/// Gets an optional boolean from a JSON object.
bool optBoolean(Map<String, dynamic> json, String key, [bool defaultValue = false]) {
  final value = json[key];
  if (value == null) return defaultValue;
  if (value is bool) return value;
  return value.toString().toLowerCase() == 'true';
}

/// Gets a required int from a JSON object.
int getInt(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) {
    throw ArgumentError('Required key "$key" not found');
  }
  if (value is int) return value;
  return int.parse(value.toString());
}

/// Gets an optional int from a JSON object.
int optInt(Map<String, dynamic> json, String key, [int defaultValue = 0]) {
  final value = json[key];
  if (value == null) return defaultValue;
  if (value is int) return value;
  return int.tryParse(value.toString()) ?? defaultValue;
}

/// Gets a required JSON array from a JSON object.
List<dynamic> getJSONArray(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) {
    throw ArgumentError('Required key "$key" not found');
  }
  if (value is List) return value;
  throw ArgumentError('Value for "$key" is not a list');
}

/// Gets an optional JSON array from a JSON object.
List<dynamic> optJSONArray(Map<String, dynamic> json, String key, [List<dynamic> defaultValue = const []]) {
  final value = json[key];
  if (value == null) return defaultValue;
  if (value is List) return value;
  return defaultValue;
}

/// Gets a JSON object from a JSON array at the specified index.
Map<String, dynamic> getJsonObject(List<dynamic> array, int index) {
  final value = array[index];
  if (value is Map<String, dynamic>) return value;
  if (value is Map) return Map<String, dynamic>.from(value);
  throw ArgumentError('Value at index $index is not a Map');
}

/// Gets a string from a JSON array at the specified index.
String getStringFromArray(List<dynamic> array, int index) {
  return array[index].toString();
}
