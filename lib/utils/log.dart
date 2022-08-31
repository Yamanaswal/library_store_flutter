
import 'package:flutter/foundation.dart';
import 'dart:developer' as logger;

class Log {

  var _kDebugMode = false;

  Log(kDebugMode){
    _kDebugMode = kDebugMode;
  }

  void e(String tag, Object? message) {
    if (_kDebugMode) {
      logger.log(tag, error: message);
    }
  }

}



