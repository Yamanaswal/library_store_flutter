
import 'dart:developer' as logger;

class Log {

  static var _kDebugMode = true;

  set kDebugMode(value) {
    _kDebugMode = value;
  }

  // Singleton Class Object
  static final Log _singleton = Log._internal();

  factory Log() {
    return _singleton;
  }

  Log._internal();

  static void e(String tag, Object? message) {
    if (_kDebugMode) {
      logger.log(tag, error: message);
    }
  }

  static void d(String tag, Object? message) {
    if (_kDebugMode) {
      logger.log(tag, error: message);
    }
  }
}



