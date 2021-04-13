import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hackust_fakeust/Components/LeaderBoard.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  LeaderBoardState createState() => LeaderBoardState();
}

class LeaderBoardState extends State<LeaderBoardPage> {
  var eventIndex = 0;

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
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: screenHeight * 0.2,
                  viewportFraction: screenHeight * 0.2 / (screenWidth - 20),
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    print('event: ' + index.toString());
                    setState(() {
                      eventIndex = index;
                      print(eventIndex);
                    });
                  },
                ),
                items: [0, 1, 2, 3].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(child: Text(i.toString())),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xFF44CF73),
                ),
                child: Center(child: Text('Event $eventIndex')),
              ),
            ),
          ],
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
