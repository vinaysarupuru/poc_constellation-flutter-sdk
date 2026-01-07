import '../../api/component_context.dart';
import '../../log.dart';
import '../json_utils.dart';
import 'field.dart';

/// DateTime field component.
class DateTimeComponent extends FieldComponent {
  static const String _tag = 'DateTimeComponent';

  String _clockFormat = '';

  DateTimeComponent(ComponentContext context) : super(context);

  String get clockFormat => _clockFormat;

  @override
  void applyProps(Map<String, dynamic> props) {
    super.applyProps(props);
    _clockFormat = getString(props, 'clockFormat');
  }

  /// Returns the timezone offset in minutes for the given timezone string.
  /// Note: Full timezone support would require additional packages like 'timezone'.
  /// This implementation attempts to parse common timezone offset formats.
  static int getTimeZoneOffset(String timeZone) {
    if (timeZone.isEmpty) {
      Log.w(_tag, 'Time zone is empty, defaulting to UTC');
      return 0;
    }

    // Check for UTC
    if (timeZone.toUpperCase() == 'UTC' || timeZone == 'GMT') {
      return 0;
    }

    // Try to parse offset format like "+05:30" or "-08:00"
    final offsetRegex = RegExp(r'^([+-])(\d{1,2}):?(\d{2})?$');
    final match = offsetRegex.firstMatch(timeZone);
    if (match != null) {
      final sign = match.group(1) == '+' ? 1 : -1;
      final hours = int.tryParse(match.group(2) ?? '0') ?? 0;
      final minutes = int.tryParse(match.group(3) ?? '0') ?? 0;
      return sign * (hours * 60 + minutes);
    }

    // For named timezones (e.g., "America/New_York"), fall back to system timezone
    // Full timezone support would require the 'timezone' package
    try {
      Log.w(_tag, 'Named timezone "$timeZone" not fully supported, using system timezone');
      final now = DateTime.now();
      return now.timeZoneOffset.inMinutes;
    } catch (e) {
      Log.w(_tag, 'Failed to get timezone offset: $e');
      return 0;
    }
  }
}
