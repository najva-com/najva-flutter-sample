import 'package:najvaflutter/najvaflutter.dart';

class Najva extends NajvaFlutter {
  int campaignId = 1247428; // your campaignId here
  int websiteId = 5753; // your websiteId here
  String apiKey = "ad9f8d79-1e87-4b61-aa55-7f0be6f2fc6f"; //your api key here
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
