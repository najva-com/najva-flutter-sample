import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:najvaflutter/najvaflutter.dart';

import 'Najva.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  Najva najva;
  @override
  void initState() {
    super.initState();
    najva = new Najva();
  }

  void onButtonClicked(){

    najva.getSubscribedToken().then((token)=> {print("token: ${token}")});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Text("Running on $_platformVersion"),
            FloatingActionButton(onPressed: onButtonClicked)
          ],),
        ),
      ),
    );
  }
}
