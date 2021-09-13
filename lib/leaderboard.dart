import 'package:flutter/material.dart';
import 'home.dart';

class Score extends StatelessWidget {
  final int score;
  final String name;

  Score({
    this.score,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: Row(
        children: <Widget>[
          Text('$score'),
          Text(name),
        ],
      ),
    );
  }
}

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  StreamBuilder buildLeaderboard() {
    return StreamBuilder(
      stream: scoresRef
        .doc()
        .collection('scores')
        .orderBy('scores', descending: true)
        .snapshots(),
      builder: (context, snapshot) {
        var allScores = <Score>[];
        snapshot.data.forEach((doc) {
          allScores.add(new Score(score: doc['score'], name: doc['name']));
        });
        return ListView(
          children: allScores,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboard"),
      ),
      body: Column(
        children: <Widget>[
          buildLeaderboard(),
        ],
      )
    );
  }
}