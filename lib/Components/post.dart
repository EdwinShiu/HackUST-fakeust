// import '../Constants/constants.dart';
import 'package:flutter/material.dart';
import "package:like_button/like_button.dart";
import 'package:loading_animations/loading_animations.dart';
import "../Constants/constants.dart";
import "../models/post_model.dart";

import 'package:cached_network_image/cached_network_image.dart';

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
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: post.getImageURL(),
                                      fadeInDuration:
                                          const Duration(milliseconds: 10),
                                      // imageUrl: post.getImageURL(),
                                      placeholder: (context, url) =>
                                          LoadingRotating.square(
                                        duration: Duration(milliseconds: 500),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
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

                            // username
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                ),

                                // username
                                child: Text(
                                  // "fwefwegfewgwegwe",
                                  post.username,
                                  style: TextStyle(
                                      backgroundColor: Colors.black,
                                      fontSize: 20,
                                      color: Colors.white),
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
                        (post.location_name == "other")
                            ? post.region_name
                            : post.location_name,
                        // post.description,
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
