class Logger {
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';

  static void success(String message) {
    print('$_green[SUCCESS] $message$_reset');
  }

  static void warning(String message) {
    print('$_yellow[WARNING] $message$_reset');
  }

  static void error(String message) {
    print('$_red[ERROR] $message$_reset');
  }

  static void info(String message) {
    print('$_blue[INFO] $message$_reset');
  }
}
