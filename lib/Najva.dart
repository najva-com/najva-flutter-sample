import 'package:najvaflutter/najvaflutter.dart';

class Najva extends NajvaFlutter {
  int campaignId = 1247618; // your campaignId here
  int websiteId = 5943; // your websiteId here
  String apiKey = "72e19a69-b226-44d8-9e4b-a9b97d01433f"; //your api key here

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
