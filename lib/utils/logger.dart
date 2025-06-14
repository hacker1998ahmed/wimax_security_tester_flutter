import 'dart:developer' as dev;
import 'package:logger/logger.dart';

class AppLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      colors: true,
    ),
  );

  static void debug(String message) {
    _logger.d(message);
    dev.log(message, name: 'DEBUG');
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
    dev.log(message, name: 'ERROR');
  }
}