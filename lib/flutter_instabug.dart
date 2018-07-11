import 'dart:async';

import 'package:flutter/services.dart';

enum IBGInvocationEvent {
  screenshot, floatingButton, shake, twoFingersSwipeLeft, rightEdgePan
}

class FlutterInstabug {
  static const MethodChannel _channel =
      const MethodChannel('flutter_instabug');

  static Future<String> startInstabug(String token, { IBGInvocationEvent invocationEvent }) async {
    String invocationEventString = "screenshot";
    if (invocationEvent != null){
      invocationEventString = invocationEvent.toString().split('.')[1];
    }
    return await _channel.invokeMethod('startInstabug', { "token" : token, "invocationEvent" : invocationEventString } );
  }

  static Future<String> identifyUser(String userEmail, { String userName }) async {
    Map<String, String> params = { "email" : userEmail};
    if (userName != null) {
      params["name"] = userName;
    }
    return await _channel.invokeMethod('identifyUser', params);
  }
}
