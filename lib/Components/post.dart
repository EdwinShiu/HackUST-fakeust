// import '../Constants/constants.dart';
import 'package:flutter/material.dart';
import "package:like_button/like_button.dart";
import "../Constants/constants.dart";

class Post extends StatefulWidget {
  final String caption;
  final String username;
  final int likeCount;
  final String image;

  const Post(
      {Key key,
      this.username = "loading",
      this.image = "",
      this.likeCount = 0,
      this.caption = "loading"})
      : super(key: key);

  @override
  _Post createState() => _Post();
}

class _Post extends State<Post> {
  @override
  void initState() {
    super.initState();
  }

  // update like count to database
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;

    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print('built');
    return Container(
      height: screenHeight * postArea,
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        children: [
          // Image
          Container(
            height: screenHeight * imageArea,
            // image background
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/logCard2.jpeg"),
                //         image:
                // NetworkToFileImage(
                //   url: "https://example.com/someFile.png",
                //   file: myFile);

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
                          alignment: Alignment.center,
                          child: Text(
                            widget.username,
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
                      widget.caption,
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
                      likeCount: widget.likeCount,
                      // onTap: onLikeButtonTapped,
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
