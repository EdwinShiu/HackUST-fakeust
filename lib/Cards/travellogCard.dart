

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Components/LeaderBoard.dart';

class LogCard extends StatelessWidget {
  final String caption;
  final String title;
  static const IconData bookmark = IconData(0xe5f8, fontFamily: 'MaterialIcons');

  LogCard({
    this.title = 'DEFAULT TITLE',
    this.caption = 'Default caption aaaaaa aaaaaaaaa aaa aaaaaaa aaaaaaaa',
  });

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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logCard.jpeg"),
                    fit: BoxFit.cover,
                  ),
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
            Expanded(
              child: LikeButton(
                size:25, likeCount: 998,
                // likeBuilder: (bool like){
                //   return Icon(FontAwesomeIcons.solidThumbsUp,
                //   color:like?Colors.black:Colors.grey,);
                // },
              ),
            ),
          ], // padding
        ),
      ),
    );
  }
}

// class Like extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(40),
//         color: Colors.grey[400],
//         child: Text('hello'),
//       )
//     );
//   }
// }
// 
class TimeLine extends StatefulWidget {
  const TimeLine({
    Key key,
  }) : super(key: key);

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5),
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
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(Icons.circle, color: Colors.white,),
                      ),
                      Container(
                        width: 2,
                        height: 80,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                
                // Expanded(
                //   flex:2,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20.0),
                //       color: Colors.white,
                //       boxShadow: [BoxShadow(
                //         blurRadius: 10,
                //         color: Colors.black26
                //         )]
                //     ),
                //     height: 180,
                //     child: Column(
                //       children: <Widget>[
                //         SizedBox(height: 20),
                //         _buildName(imageAsset: "assets/images/logCard.jpeg", name: "Name 1", score: 6000),
                //         LikeButton(size:25, likeCount: 998,),
                //         ],
                //       )
                //     ),
                //   ),
              ],
            ),
          );
        }),
    );
  }
  Widget _buildName({String imageAsset, String name, double score}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      children: <Widget>[
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(20.0),
            //   child: Container(
            //     height: 150.0,
            //     width: 150.0,
            //     child: Image(image: AssetImage(imageAsset))
            //   )
            // ),
            CircleAvatar(
              backgroundImage: AssetImage(imageAsset),
              radius: 50,
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

