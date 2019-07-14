import 'package:najvaflutter/najvaflutter.dart';

class Najva extends NajvaFlutter {
  int campaignId = 1247604; // your campaignId here
  int websiteId = 5929; // your websiteId here
  String apiKey = "ada0ff89-408e-4ffe-bf0b-2f1fb3ff77a1"; //your api key here
  bool locationEnabled =
      true; //set true if you want get location-based improvements

  /// constructor for Najva
  Najva() {
    init(campaignId, websiteId, apiKey, locationEnabled);

    // you can call initUserHandling() method if you want to get warned about users
  }

  /// json data will be send to this method
  @override
  void onNewJSONDataReceived(String jsonData) {
    // TODO: handle new message from server
    print(jsonData);
  }

  @override
  void onUserSubscribed(String token) {
    // TODO: implement onUserSubscribed
    print(token);
  }
}
