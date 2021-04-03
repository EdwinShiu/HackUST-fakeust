// import '../Constants/constants.dart';
import 'package:flutter/material.dart';
import "package:like_button/like_button.dart";

class Post extends StatelessWidget {
  String caption;
  double postArea;
  double imageArea;
  double locationrowArea;
  double usernameArea;
  // Post( {
  //   postArea = 0.52;
  //   imageArea = postArea * 0.88;
  // })
  Post() {
    postArea = 0.52;
    imageArea = postArea * 0.88;
    locationrowArea = postArea * 0.12;
    usernameArea = postArea * 0.09;
    caption =
        "Lorem ipsum dolor sit amet, consectetu tincidunt risus, aliquet mollis arcu magna ut eros. ";
  }
  // final double usernameRowArea = 0.1;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * postArea,
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 0),
      // color: Colors.amber,
      child: Column(
        children: [
          // Username and tag container
          // Container(
          //   height: screenHeight * postArea * 0.1,
          //   // color: Colors.white,
          //   child: Stack(
          //     children: [
          //       Align(
          //         alignment: Alignment.centerLeft,
          //         child: Padding(
          //           padding: EdgeInsets.only(left: 10),
          //           child: Text('USERNAME'),
          //         ),
          //       ),
          //       // tag
          //       Align(
          //         alignment: Alignment.centerRight,
          //         child: Padding(
          //           padding: EdgeInsets.only(right: 10),
          //           child: Container(
          //             height: screenHeight * postArea * 0.03,
          //             width: 20,
          //             color: Colors.red,
          //           ),
          //         ),
          //       ),
          //       // tag
          //       Align(
          //         alignment: Alignment.centerRight,
          //         child: Padding(
          //           padding: EdgeInsets.only(right: 40),
          //           child: Container(
          //             height: screenHeight * postArea * 0.03,
          //             width: 20,
          //             color: Colors.blue,
          //           ),
          //         ),
          //       ),
          //       // tag
          //       Align(
          //         alignment: Alignment.centerRight,
          //         child: Padding(
          //           padding: EdgeInsets.only(right: 70),
          //           child: Container(
          //             height: screenHeight * postArea * 0.03,
          //             width: 20,
          //             color: Colors.green,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // Image
          Container(
            height: screenHeight * imageArea,
            // image background
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logCard2.jpeg"),
                // fit makes the image occupies the whole allocated space
                fit: BoxFit.cover,
              ),
            ),
            // username
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    height: screenHeight * usernameArea,
                    width: screenWidth * 0.4,
                    child: Stack(
                      children: [
                        Container(
                          height: screenHeight * usernameArea,
                          width: screenHeight * usernameArea,
                          // color: Colors.white,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/profilePic.png"),
                              // fit makes the image occupies the whole allocated space
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "USERNAME",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                  // child: Text(
                  //   "USERNAME",
                  //   style: TextStyle(fontSize: 20, color: Colors.white),
                  // ),
                  ),
            ),
          ),

          // Location, Name and Like
          Container(
            height: screenHeight * locationrowArea,
            width: screenWidth,
            // color: Colors.black,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
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
          ),
        ],
      ),
    );
  }
}
