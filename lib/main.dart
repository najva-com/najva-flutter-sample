import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:najvaflutter/najvaflutter.dart';
import 'package:http/http.dart' as http;

NajvaFlutter najva;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  najva = new NajvaFlutter();
  najva.init("8b84ad3a-3daa-4520-9adc-d7528ea95a54", 12383);
  runApp(MyApp());
}


var player = true;

var gameDone = false;
var message = "";
var count = 0;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {


  Animation<double> animation;
  AnimationController controller;

  String token = "Not available yet.";

  @override
  void initState() {
    super.initState();
    najva.setOnUserSubscribedListener(onUserSubscribed);
    najva.getSubscribedToken().then((value) => {
      setState(() {
        token = value;
      })
    });
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation.addListener(() {
      setState(() {});
    });
  }

  void onUserSubscribed(String token){
    setState(() {
      this.token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Najva Sample app'),
        ),
        body: Center(child: getContent()),
      ),
    );
  }

  void sendANotification(){
    requestToServer().then((value) => {
      print(value)
    });
  }

  Future<String> requestToServer() async {
    final response = await http.post(
        "https://app.najva.com/notification/api/v1/notifications/",
        headers: <String,String>{
          "authorization": "Token aff3c68af97bf4608fdf28673ca26201ca027ed9",
          "content-type": "application/json"
        },
        body: jsonEncode(<String,dynamic>{
          "api_key":"8b84ad3a-3daa-4520-9adc-d7528ea95a54",
          "title": "Notification from API",
          "body": "this notification has been send from flutter sample",
          "url":"https://najva.com",
          "onclick-action":"open-link",
          "priority": "high",
          "subscriber_tokens": [token],
        }));
    return response.body;
  }

  Widget getContent() {
      return  Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.all(8),
                child: Text(token),
              ),

              Flexible(
                child: Container(
                  child: Flexible(
                      child: ButtonTheme(
                        height: 80,
                        child: RaisedButton(
                          color: Colors.blueAccent,
                          onPressed: () {
                            sendANotification();
                          },
                          child: Text("SEND A NOTIFICATION"),
                        ),
                      ),
                      flex: 2)
                ),
                flex: 1,
              )
            ],
          );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
