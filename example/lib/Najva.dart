import 'package:najvaflutter/najvaflutter.dart';

class Najva extends NajvaFlutter {
  int campaignId = 1247604; // your campaignId here
  int websiteId = 5929; // your websiteId here
  String apiKey = "ada0ff89-408e-4ffe-bf0b-2f1fb3ff77a1"; //your api key here

  /// constructor for Najva
  Najva() {
    init(campaignId, websiteId, apiKey);

    // you can call initUserHandling() method if you want to get warned about users
    initUserHandling();

    getSubscribedToken().then((token) => {  print("user token: ${token}") });

  }

  /// json data will be send to this method
  @override
  void _onNewJSONDataReceived(String jsonData) {
    // TODO: handle new message from server
    print(jsonData);
  }

  @override
  void _onUserSubscribed(String token) {
    // TODO: implement onUserSubscribed
    print(token);
  }


}
