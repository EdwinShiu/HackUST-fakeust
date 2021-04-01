import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogCard extends StatelessWidget {
  final String caption;
  final String title;

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

class Like extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        color: Colors.grey[400],
        child: Text('hello'),
      )
    );
  }

}
