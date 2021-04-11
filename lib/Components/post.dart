// import '../Constants/constants.dart';
import 'package:flutter/material.dart';
import "package:like_button/like_button.dart";
// import 'package:loading_animations/loading_animations.dart';
import "../Constants/constants.dart";

class Post extends StatefulWidget {
  final String caption;
  final String username;
  final int likeCount;
  final String imageURL;
  final imagePATH;
  final String postId;
  final String currentUid;

  const Post({
    Key key,
    this.username = "loading",
    this.imageURL = "",
    this.imagePATH = "",
    this.likeCount = 0,
    this.caption = "loading",
    this.postId = "",
    this.currentUid = "",
  }) : super(key: key);

  @override
  _Post createState() => _Post();
}

class _Post extends State<Post> {
  @override
  void initState() {
    super.initState();
  }

  // update like count to database
  // Future<bool> onLikeButtonTapped(bool isLiked) async {
  //   int temp_like;
  //   List<String> temp_list;
  //   print("POSTID ${widget.postId}");
  //   await FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(widget.postId)
  //       .get()
  //       .then((_querySnapshot) {
  //     temp_like = _querySnapshot.data()['like_count'];
  //     temp_list = _querySnapshot.data()['like_uid'];
  //   });
  //   print(temp_list.toString());
  //   print(temp_like.toString());

  //   await FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(widget.postId)
  //       .update({
  //     "like_count": temp_like + 1,
  //     // "like_uid": temp_list + [widget.currentUid]
  //   });

  //   return !isLiked;
  // }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // print('post built');
    return Container(
      height: screenHeight * postArea,
      width: screenWidth,
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        children: [
          // Image and username
          (widget.imageURL == "" && widget.imagePATH == "")
              ? Container(
                  height: screenHeight * imageArea,
                  child: Container(),
                )
              :
              // username
              Container(
                  height: screenHeight * imageArea,
                  width: screenWidth,
                  child: Stack(
                    children: [
                      (widget.imagePATH == "")
                          ? Container(
                              height: screenHeight * imageArea,
                              width: screenWidth,
                              child: Image.network(
                                widget.imageURL,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;

                                  // return LoadingRotating.square(
                                  //   duration: Duration(milliseconds: 500),
                                  // );
                                  // or LinearProgressIndicator or CircularProgressIndicator instead
                                  return LinearProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Text('Some errors occurred!'),
                              ),
                            )
                          : Container(
                              height: screenHeight * imageArea,
                              // image background
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(widget.imagePATH),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
                                  Container(
                                    height: screenHeight * usernameArea,
                                    width: screenHeight * usernameArea,
                                    // color: Colors.white,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/profilePic.png"),
                                        // fit makes the image occupies the whole allocated space
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      widget.username,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
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
                    ],
                  ),
                ),

          // Location, Name and Like
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
                        widget.caption,
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
                        likeCount: widget.likeCount,
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
