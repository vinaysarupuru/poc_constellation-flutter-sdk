/// Simple logging utility.
class Log {
  static void i(String tag, String message) {
    print('I: [$tag] $message');
  }

  static void w(String tag, String message) {
    print('W: [$tag] $message');
  }

  static void e(String tag, String message, [Object? error]) {
    print('E: [$tag] $message ${error?.toString() ?? ''}');
  }
}
