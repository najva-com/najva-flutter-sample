import 'dart:collection';

import 'package:najvaflutter/najvaflutter.dart';

class Najva extends NajvaFlutter {
  Najva(){
    init();

    getCachedJsonData();

    print(getSubscribedToken());
  }

  @override
  void onUserSubscribed(String token) {
    // TODO: implement onUserSubscribed
    super.onUserSubscribed(token);
    print(token);
  }

  @override
  void onNewJSONDataReceived(String jsonData) {
    // TODO: implement onNewJSONDataReceived
    super.onNewJSONDataReceived(jsonData);
    print(jsonData);
  }

  @override
  void onNotificationClicked(LinkedHashMap<dynamic, dynamic> data) {
    print("notification clicked: $data");
  }

  @override
  void onNotificationReceived(LinkedHashMap<dynamic, dynamic> data) {
    print("notification received: $data");
  }
}