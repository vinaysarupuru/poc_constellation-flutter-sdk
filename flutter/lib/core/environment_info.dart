/// Represents information about the application environment that the user is currently logged into.
class EnvironmentInfo {
  /// Current locale in IETF BCP 47 format, e.g. "en-US"
  final String locale;

  /// Current time zone in TZ database format, e.g. "America/New_York"
  final String timeZone;

  const EnvironmentInfo({
    required this.locale,
    required this.timeZone,
  });

  /// Creates EnvironmentInfo from a JSON map.
  factory EnvironmentInfo.fromJson(Map<String, dynamic> json) {
    return EnvironmentInfo(
      locale: json['locale'] as String? ?? 'en-US',
      timeZone: json['timeZone'] as String? ?? 'America/New_York',
    );
  }

  Map<String, dynamic> toJson() => {
    'locale': locale,
    'timeZone': timeZone,
  };
}
