import 'dart:async';

import 'package:flutter/services.dart';

class NajvaFlutter {
  ///final variables used for keys in arguments map
  static const String CAMPAIGN_ID = "champaignId";
  static const String WEBSITE_ID = "website_id";
  static const String API_KEY = "api_key";
  static const String LOCATION = "location";

  ///final variables used for method names
  static const String INIT = "init";
  static const String HANDLE_JSON_NOTIFICATION = "handle_json_notification";
  static const String HANDLE_USERS_TOKEN = "handle_users_token";
  static const String GET_SUBSCRIBED_TOKEN = "get_subscribed_token";

  ///final variables for dart method names
  static const String NEW_JSON_DATA = "onNewJSONData";
  static const String NEW_USER_SUBSCRIBED = " onUserSubscribed";

  MethodChannel _channel = const MethodChannel('najvaflutterplugin');

  bool isNajvaInitialized = false;

  Future<dynamic> handler(MethodCall call) {
    String name = call.method;
    switch (name) {
      case NEW_JSON_DATA:
        deliverJSONData(call.arguments);
        break;
      case NEW_USER_SUBSCRIBED:
        deliverUserSubscription(call.arguments);
        break;
    }
  }

  Future<void> init(int campaignId, int websiteId, String apiKey) async {
    Map<String, String> map = new Map();
    map[CAMPAIGN_ID] = "$campaignId";
    map[WEBSITE_ID] = "$websiteId";
    map[API_KEY] = apiKey;

    try {
      isNajvaInitialized = await _channel.invokeMethod(INIT, map);
      _channel.setMethodCallHandler(handler);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  // ignore: missing_return
  Future<void> initUserHandling() {
    _channel.invokeMethod(HANDLE_USERS_TOKEN);
  }

  // ignore: missing_return
  Future<void> initJSONNotification() {
    _channel.invokeMethod(HANDLE_JSON_NOTIFICATION);
  }

  void deliverJSONData(arguments) {
    _onNewJSONDataReceived(arguments);
  }

  void deliverUserSubscription(arguments) {
    print("najva token: $arguments");
    _onUserSubscribed(arguments);
  }

  void _onNewJSONDataReceived(String jsonData) {}

  void _onUserSubscribed(String token) {}

  Future<String> getSubscribedToken() async {
    String token = await _channel.invokeMethod(GET_SUBSCRIBED_TOKEN);
    return token;
  }
}
