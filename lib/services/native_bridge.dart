import 'package:flutter/services.dart';

class NativeBridge {
  static const _channel = MethodChannel('com.wimax.pentest/native');

  static Future<bool> requestRoot() async {
    try {
      return await _channel.invokeMethod('requestRoot');
    } on PlatformException catch (e) {
      throw Exception('Root request failed: ${e.message}');
    }
  }

  static Future<String> executeAsRoot(String command) async {
    try {
      return await _channel.invokeMethod('executeAsRoot', {'command': command});
    } on PlatformException catch (e) {
      throw Exception('Command failed: ${e.message}');
    }
  }
}