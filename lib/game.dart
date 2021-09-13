import 'package:flutter/material.dart';
import 'dart:async';
import 'submit.dart';

class Game extends StatefulWidget {
  const Game({Key key}) : super(key: key);
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _counter = 0;
  int _timer = 30;
  bool _isCounting = false;
  bool _isFinished = false;

  void _incrementCounter() {
    if (!_isFinished) {
      setState(() {
        _counter++;
      });
    }
  }

  void _startTimer() {
    _isCounting = true;
    _incrementCounter();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_timer == 1) {
        timer.cancel();
        _isFinished = true;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Submit(
            score: _counter,
          ))
        );
      }
      setState(() {
        _timer--;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Press the button as many times as you can!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_timer',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              onPressed: _startTimer,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isCounting ? _incrementCounter : _startTimer,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}