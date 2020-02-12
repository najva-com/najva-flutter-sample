import 'package:flutter/material.dart';

import 'Najva.dart';

void main() => runApp(MyApp());

var map = [
  [Colors.amber, Colors.amber, Colors.amber],
  [Colors.amber, Colors.amber, Colors.amber],
  [Colors.amber, Colors.amber, Colors.amber]
];

var player = true;

var gameDone = false;
var message = "";
var count = 0;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Najva najva;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    najva = new Najva();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation.addListener(() {
      setState(() {});
    });
  }

  void onButtonClicked(int x, int y) {
    if (map[x][y] != Colors.amber) {
      return;
    }
    count++;
    setState(() {
      if (player) {
        map[x][y] = Colors.blue;
      } else {
        map[x][y] = Colors.red;
      }

      checkGame(x, y);

      if (!gameDone) {
        player = !player;
        if (count >= 9) {
          gameDone = true;
          message = "Game has been a draw";
          controller.forward();
        }
      } else {
        message = "Player ${getPlayerNumber()} won the game";
        controller.forward();
      }
    });
  }

  int getPlayerNumber() {
    if (player) {
      return 1;
    } else {
      return 2;
    }
  }

  void checkGame(int x, int y) {
    if (map[x][0] == map[x][1] && map[x][0] == map[x][2]) {
      gameDone = true;
    }
    if (map[0][y] == map[1][y] && map[0][y] == map[2][y]) {
      gameDone = true;
    }
    if (map[0][0] != Colors.amber &&
        map[0][0] == map[1][1] &&
        map[0][0] == map[2][2]) {
      gameDone = true;
    }
    if (map[1][1] != Colors.amber &&
        map[2][0] == map[1][1] &&
        map[1][1] == map[0][2]) {
      gameDone = true;
    }
  }

  void resetGame() {
    setState(() {
      for (var row in map) {
        for (var item in row) {
          map[map.indexOf(row)][row.indexOf(item)] = Colors.amber;
        }
      }
      gameDone = false;
      player = true;
    });
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tic Toc Toe'),
        ),
        body: Center(child: getContent()),
      ),
    );
  }

  Widget getContent() {
    if (gameDone) {
      return Transform.translate(
          child: Column(
            children: <Widget>[
              Text(message),
              RaisedButton(
                child: Text("reset"),
                onPressed: resetGame,
              )
            ],
          ),
          offset: Offset(0, animation.value));
    } else {
      return Card(
        color: Colors.teal,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Container(
                  height: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: ButtonTheme(
                            height: 80,
                            child: RaisedButton(
                              color: map[0][0],
                              onPressed: () {
                                onButtonClicked(0, 0);
                              },
                            ),
                          ),
                          flex: 2),
                      Flexible(
                          child: ButtonTheme(
                            height: 80,
                            child: RaisedButton(
                              color: map[1][0],
                              onPressed: () {
                                onButtonClicked(1, 0);
                              },
                            ),
                          ),
                          flex: 1),
                      Flexible(
                          child: ButtonTheme(
                            height: 80,
                            child: RaisedButton(
                              color: map[2][0],
                              onPressed: () {
                                onButtonClicked(2, 0);
                              },
                            ),
                          ),
                          flex: 1),
                    ],
                  ),
                ),
                flex: 1,
              ),
              Flexible(
                child: Container(
                  height: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: ButtonTheme(
                            height: 80,
                            child: RaisedButton(
                              color: map[0][1],
                              onPressed: () {
                                onButtonClicked(0, 1);
                              },
                            ),
                          ),
                          flex: 1),
                      Flexible(
                          child: ButtonTheme(
                            height: 80.0,
                            child: RaisedButton(
                              color: map[1][1],
                              onPressed: () {
                                onButtonClicked(1, 1);
                              },
                            ),
                          ),
                          flex: 1),
                      Flexible(
                          child: ButtonTheme(
                            height: 80,
                            child: RaisedButton(
                              color: map[2][1],
                              onPressed: () {
                                onButtonClicked(2, 1);
                              },
                            ),
                          ),
                          flex: 1),
                    ],
                  ),
                ),
                flex: 1,
              ),
              Flexible(
                child: Container(
                  height: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: ButtonTheme(
                            height: 80,
                            child: RaisedButton(
                              color: map[0][2],
                              onPressed: () {
                                onButtonClicked(0, 2);
                              },
                            ),
                          ),
                          flex: 1),
                      Flexible(
                          child: ButtonTheme(
                            height: 80.0,
                            child: RaisedButton(
                              color: map[1][2],
                              onPressed: () {
                                onButtonClicked(1, 2);
                              },
                            ),
                          ),
                          flex: 1),
                      Flexible(
                          child: ButtonTheme(
                            height: 80.0,
                            child: RaisedButton(
                              color: map[2][2],
                              onPressed: () {
                                onButtonClicked(2, 2);
                              },
                            ),
                          ),
                          flex: 1),
                    ],
                  ),
                ),
                flex: 1,
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
