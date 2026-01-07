import '../log.dart';

/// Converts a Map/List/primitive to a JSON-like structure.
dynamic toJsonElement(dynamic value) {
  if (value is String || value is int || value is double || value is bool) {
    return value;
  }
  if (value is List) {
    return value.map((e) => e != null ? toJsonElement(e) : null).whereType<dynamic>().toList();
  }
  if (value is Map) {
    final result = <String, dynamic>{};
    for (final entry in value.entries) {
      if (entry.key is String) {
        final jsonValue = entry.value != null ? toJsonElement(entry.value) : null;
        if (jsonValue != null) {
          result[entry.key as String] = jsonValue;
        }
      } else {
        Log.w('JsonHelper', 'Map key <${entry.key}> is not a String, cannot convert to JsonObject.');
      }
    }
    return result;
  }
  Log.w('JsonHelper', 'Unsupported type ${value.runtimeType}, cannot convert to JsonElement.');
  return null;
}
