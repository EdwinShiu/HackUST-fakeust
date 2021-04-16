// import '../Constants/constants.dart';
import 'package:flutter/material.dart';
import "package:like_button/like_button.dart";
import 'package:loading_animations/loading_animations.dart';
import "../Constants/constants.dart" as constants;
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
    double postArea = 0.57;
    double imageArea = postArea * 0.81;
    double infocolArea = postArea * 0.19;

    List<String> tags = post.getTags;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Image and username
        Container(
          height: screenHeight * imageArea,
          width: screenWidth,
          child: Stack(
            children: [
              // Image and username
              (post.getImageURL == "" && this.imagePATH == "")
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
                                    imageUrl: post.getImageURL,
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
            ],
          ),
        ),

        // Location and Like

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: (tags.isNotEmpty)
                  ? screenHeight * infocolArea * 0.35
                  : screenHeight * infocolArea * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: (tags.isNotEmpty)
                            ? const EdgeInsets.only(left: 15, top: 5)
                            : const EdgeInsets.only(left: 15),
                        // region or location
                        child: Text(
                          (post.location_name == "other")
                              ? post.region_name
                              : post.location_name,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, right: 20),
                      child: LikeButton(
                        size: (tags.isNotEmpty) ? 20 : 30,
                        // likeCount: widget.likeCount,
                        // onTap: onLikeButtonTapped,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (tags.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 18.0),
                    child: Container(
                      height: screenHeight * infocolArea * 0.3,
                      child: CustomScrollView(
                        scrollDirection: Axis.horizontal,
                        slivers: <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 2, left: 8.0),
                                  child: FittedBox(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                            constants.tagColor[tags[index]]),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: FittedBox(
                                          child: Text(tags[index]),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: tags.length,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }
}
