import 'dart:io';
import 'dart:collection';
import 'dart:math';

import 'package:najvaflutter/najvaflutter.dart';
import 'package:http/http.dart';
import 'package:najvaflutter_example/main.dart';

class Najva extends NajvaFlutter {

  /// constructor for Najva
  Najva() {
    enableLocation();

    setFirebaseEnabled(false);// set to true if you want to najva use your firebase account

    init();

    getSubscribedToken().then((token) => {print("user token: $token")});
  }

  void _sendTokenToServer(String token) async {
    String url = "https://google.com/generate_201";
    Map<String, String> headers = {"Content-type": "application/json"};
    String body = '{"token":"$token"}';

    var response = await post(url, headers: headers, body: body);
    var statusCode = response.statusCode;
    var content = response.body;
    print("statusCode: $statusCode");
    print("response: $content");
  }

  @override
  void onUserSubscribed(String token) {
    _sendTokenToServer(token);
    print(token);
  }

  @override
  void onNotificationClicked(LinkedHashMap<dynamic,dynamic> data) {
    var id = data['notification_id'];
    log(id);
  }

  @override
  void onNotificationReceived(LinkedHashMap<dynamic,dynamic> data) {
    var id = data['notification_id'];
    log(id);
  }
}
