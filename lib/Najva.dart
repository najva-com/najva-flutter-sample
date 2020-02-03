import 'dart:io';

import 'package:najvaflutter/najvaflutter.dart';
import 'package:http/http.dart';
import 'package:najvaflutter_example/main.dart';

class Najva extends NajvaFlutter {
  int campaignId = 0; // your campaignId here
  int websiteId = 0; // your websiteId here
  String apiKey = ""; //your api key here

  /// constructor for Najva
  Najva() {
    disableLocation();

    init();

    getSubscribedToken().then((token) => {print("user token: $token")});
  }

  /// json data will be send to this method
  @override
  void _onNewJSONDataReceived(String jsonData) {
    print(jsonData);
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
  void _onUserSubscribed(String token) {
    _sendTokenToServer(token);
    print(token);
  }
}
