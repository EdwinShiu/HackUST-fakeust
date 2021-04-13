import 'package:flutter/material.dart';

import 'package:hackust_fakeust/Components/LeaderBoard.dart';
import 'package:hackust_fakeust/Components/eventBoard.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  LeaderBoardState createState() => LeaderBoardState();
}

class LeaderBoardState extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LeaderBoard',
              style: Theme.of(context).textTheme.headline2,
            ),
            LeaderBoard(),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Text(
              'Events',
              style: Theme.of(context).textTheme.headline2,
            ),
            EventBoard(),
          ],
        ),
      ),
    );
  }
}
