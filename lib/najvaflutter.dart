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
  static const String INIT_USER_HANDLER = "init_user_handler";

  ///final variables for dart method names
  static const String NEW_JSON_DATA = "onNewJSONData";
  static const String NEW_USER_SUBSCRIBED = " onUserSubscribed";

  MethodChannel _channel = const MethodChannel('najvaflutterplugin');

  bool isNajvaInitialized = false;


  Future<dynamic> handler(MethodCall call) {
    String name = call.method;
    switch(name){
      case NEW_JSON_DATA:
        deliverJSONData(call.arguments);
        break;
      case NEW_USER_SUBSCRIBED:
        deliverUserSubscription(call.arguments);
        break;
    }
  }

  Future<void> init(int campaignId, int websiteId, String apiKey,
      bool locationEnabled) async {
    Map<String, String> map = new Map();
    map[CAMPAIGN_ID] = "$campaignId";
    map[WEBSITE_ID] = "$websiteId";
    map[API_KEY] = apiKey;
    map[LOCATION] = "$locationEnabled";

    try {
      isNajvaInitialized = await _channel.invokeMethod(INIT, map);
      _channel.setMethodCallHandler(handler);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  // ignore: missing_return
  Future<void> initUserHandling() {
    _channel.invokeMethod(INIT_USER_HANDLER);
  }

  void deliverJSONData(arguments) {
    onNewJSONDataReceived(arguments);
  }

  void deliverUserSubscription(arguments) {
    onUserSubscribed(arguments);
  }

  void onNewJSONDataReceived(String jsonData) {}

  void onUserSubscribed(String token) {}

}

