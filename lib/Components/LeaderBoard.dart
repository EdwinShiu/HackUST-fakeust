import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Testing")),
    body: Center(
      child: RaisedButton(
        child: Text("Competition 1"),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                elevation: 16,
                child: Container(
                  height: 400.0,
                  width: 360.0,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Leaderboard",
                          style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildName(imageAsset: "assets/images/logCard.jpeg", name: "Name 1", score: 6000),
                      _buildName(imageAsset: "assets/images/logCard.jpeg", name: "Name 2", score: 5000),
                      _buildName(imageAsset: "assets/images/logCard.jpeg", name: "Name 3", score: 4000),
                      _buildName(imageAsset: "assets/images/logCard.jpeg", name: "Name 4", score: 3000),
                      _buildName(imageAsset: "assets/images/logCard.jpeg", name: "Name 5", score: 2000),
                      _buildName(imageAsset: "assets/images/logCard.jpeg", name: "Name 6", score: 1000),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    ),
  );
}

Widget _buildName({String imageAsset, String name, double score}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: <Widget>[
        SizedBox(height: 12),
        Container(height: 2, color: Colors.redAccent),
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(imageAsset),
              radius: 30,
            ),
            SizedBox(width: 12),
            Text(name),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text("$score"),
              decoration: BoxDecoration(
                color: Colors.yellow[900],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}