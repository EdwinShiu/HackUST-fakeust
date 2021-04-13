// import '../Constants/constants.dart';
import 'package:flutter/material.dart';
import "package:like_button/like_button.dart";
// import 'package:loading_animations/loading_animations.dart';
import "../Constants/constants.dart";
import "../models/post_model.dart";

class Post extends StatelessWidget {
  final PostModel post;
  final imagePATH;

  const Post({Key key, @required this.post, this.imagePATH = ""})
      : assert(post != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    print("Description: ${post.description}");
    return Container(
      height: screenHeight * postArea,
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        children: [
          // Image and username

          Container(
            height: screenHeight * imageArea,
            width: screenWidth,
            child: Stack(
              children: [
                // Image and username
                (post.getImageURL() == "" && this.imagePATH == "")
                    ? Container(
                        height: screenHeight * imageArea,
                        child: Container(),
                      )
                    : Container(
                        height: screenHeight * imageArea,
                        width: screenWidth,
                        child: Stack(
                          children: [
                            (this.imagePATH == "")
                                ? Container(
                                    height: screenHeight * imageArea,
                                    width: screenWidth,
                                    child: Image.network(
                                      post.getImageURL(),
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;

                                        // return LoadingRotating.square(
                                        //   duration: Duration(milliseconds: 500),
                                        // );
                                        // or LinearProgressIndicator or CircularProgressIndicator instead
                                        return LinearProgressIndicator();
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Text('Some errors occurred!'),
                                    ),
                                  )
                                : Container(
                                    height: screenHeight * imageArea,
                                    // image background
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(this.imagePATH),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                            // profile pic and username
                            Align(
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
                                      // profilepic
                                      Container(
                                        height: screenHeight * usernameArea,
                                        width: screenHeight * usernameArea,
                                        // color: Colors.white,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/profilePic.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // username
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          post.username,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                // Location, Name and Like
              ],
            ),
          ),
          Container(
            height: screenHeight * locationrowArea,
            width: screenWidth,
            // color: Colors.black,
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        post.description,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: LikeButton(
                        size: 20,
                        // likeCount: widget.likeCount,
                        // onTap: onLikeButtonTapped,
                      ),
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
