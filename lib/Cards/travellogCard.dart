import 'package:flutter/material.dart';

import '../Components/LeaderBoard.dart';

class TravelLogCard extends StatelessWidget {
  final String caption;
  final String title;
  final imagePath;
  static const IconData bookmark =
      IconData(0xe5f8, fontFamily: 'MaterialIcons');

  TravelLogCard(
      {this.title = 'DEFAULT TITLE',
      this.caption = 'Default caption aaaaaa aaaaaaaaa aaa aaaaaaa aaaaaaaa',
      this.imagePath});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // return Padding(
    //   padding: const EdgeInsets.only(left: 40),
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        width: screenWidth * 0.85,
        height: screenHeight * 0.2,
        child: Row(
          children: [
            // travel log image
            Expanded(
              flex: 2,
              child: Container(
                child: imagePath == null
                    ? Image.asset("assets/images/logCard.jpeg")
                    : Image.network(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            // travel log text
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.amber,
                child: Column(
                  children: [
                    // title
                    Padding(
                      padding: EdgeInsets.only(top: 15, right: 50),
                      child: Text(
                        this.title,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    // caption
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Text(
                        this.caption,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ], // padding
        ),
      ),
    );
  }
}

class TimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: <Widget>[
                Container(
                  width: 2,
                  height: 80,
                  color: Colors.black,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.circle,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 2,
                  height: 80,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildName({String imageAsset, String name, double score}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: Column(
  //       children: <Widget>[
  //         SizedBox(height: 12),
  //         Row(
  //           children: <Widget>[
  //             // ClipRRect(
  //             //   borderRadius: BorderRadius.circular(20.0),
  //             //   child: Container(
  //             //     height: 150.0,
  //             //     width: 150.0,
  //             //     child: Image(image: AssetImage(imageAsset))
  //             //   )
  //             // ),
  //             CircleAvatar(
  //               backgroundImage: AssetImage(imageAsset),
  //               radius: 50,
  //             ),
  //             SizedBox(width: 12),
  //             Text(name),
  //             Spacer(),
  //             Container(
  //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
  //               child: Text("$score"),
  //               decoration: BoxDecoration(
  //                 color: Colors.yellow[900],
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
