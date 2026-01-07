import '../log.dart';

/// Display mode for components.
enum DisplayMode {
  editable,
  displayOnly,
  stackedLargeVal;

  /// Converts a string to DisplayMode.
  static DisplayMode fromString(String value) {
    switch (value) {
      case 'DISPLAY_ONLY':
        return DisplayMode.displayOnly;
      case 'STACKED_LARGE_VAL':
        return DisplayMode.stackedLargeVal;
      case 'EDITABLE':
      case '':
        return DisplayMode.editable;
      default:
        Log.w('DisplayMode', "Unknown display mode: $value, fallback to 'EDITABLE'");
        return DisplayMode.editable;
    }
  }

  String toJsonString() {
    switch (this) {
      case DisplayMode.editable:
        return 'EDITABLE';
      case DisplayMode.displayOnly:
        return 'DISPLAY_ONLY';
      case DisplayMode.stackedLargeVal:
        return 'STACKED_LARGE_VAL';
    }
  }
}
