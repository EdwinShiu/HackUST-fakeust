// import '../Constants/constants.dart';
import 'package:flutter/material.dart';
import "package:like_button/like_button.dart";

class Post extends StatelessWidget {
  final String caption =
      "Lorem ipsum dolor sit amet, consectetu tincidunt risus, aliquet mollis arcu magna ut eros. ";
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.66,
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 1),
      // color: Colors.amber,
      child: Column(
        children: [
          // Username and tag container
          Container(
            height: screenHeight * 0.66 * 0.1,
            // color: Colors.white,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text('USERNAME'),
                  ),
                ),
                // tag
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      height: screenHeight * 0.66 * 0.03,
                      width: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
                // tag
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Container(
                      height: screenHeight * 0.66 * 0.03,
                      width: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
                // tag
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 70),
                    child: Container(
                      height: screenHeight * 0.66 * 0.03,
                      width: 20,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Image
          Container(
            height: screenHeight * 0.66 * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logCard2.jpeg"),
                // fit makes the image occupies the whole allocated space
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Location, Name and Like
          Container(
            height: screenHeight * 0.66 * 0.2,
            width: screenWidth,
            // color: Colors.black,
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          'TITLE',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(left: 230, top: 10),
                        child: LikeButton(
                          size: 20,
                          likeCount: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(caption),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
