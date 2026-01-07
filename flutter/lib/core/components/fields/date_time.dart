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
  static int getTimeZoneOffset(String timeZone) {
    if (timeZone.isEmpty) {
      Log.w(_tag, 'Time zone is empty, defaulting to UTC');
      return 0;
    }
    try {
      // In Flutter, we'll use the system timezone as a fallback
      // Full timezone support would require additional packages
      final now = DateTime.now();
      return now.timeZoneOffset.inMinutes;
    } catch (e) {
      Log.w(_tag, 'Failed to get timezone offset: $e');
      return 0;
    }
  }
}
