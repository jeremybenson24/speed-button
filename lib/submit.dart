import 'package:flutter/material.dart';
import 'home.dart';

class Submit extends StatefulWidget {
  // const Submit({Key key, int score}) : super(key: key);
  final int score;

  Submit({
    this.score,
  });

  @override
  _SubmitState createState() => _SubmitState(
    score: this.score,
  );
}

class _SubmitState extends State<Submit> {
  final int score;
  String _highscore = 'New High Score!';
  TextEditingController nameController = TextEditingController();

  _SubmitState({
    this.score,
  });

  void submitScore() {
    scoresRef.doc()
        .collection('scores')
        .add({
      'score': score,
      'name': nameController.text,
    });
    nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
          appBar: AppBar(
            title: Text('eat shit and die'),
          ),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      _highscore,
                    ),
                    Text(
                        '$score'
                    ),
                    Text(
                      'Submit your score to the leaderboard by typing your name below'
                    ),
                    ListTile(
                      title: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: "Name"),
                      ),
                      trailing: OutlinedButton(
                        onPressed: () => submitScore(),
                        child: Text("Submit"),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Cancel, Return to Main Menu'),
                    )
                  ]
              )
          )
      )
    );
  }
}