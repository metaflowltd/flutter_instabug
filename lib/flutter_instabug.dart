import 'dart:async';

import 'package:flutter/services.dart';

enum IBGInvocationEvent {
  screenshot, floatingButton, shake, twoFingersSwipeLeft, rightEdgePan
}

class FlutterInstabug {
  static const MethodChannel _channel =
      const MethodChannel('flutter_instabug');

  static Future<String> startInstabug(String token) async {
    return await _channel.invokeMethod('startInstabug', {"token" : token} );
  }
}
