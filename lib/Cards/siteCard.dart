import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SiteCard extends StatefulWidget {
  final String username;
  final String caption;
  final String date;
  final imageUrl;
  static const IconData bookmark =
      IconData(0xe5f8, fontFamily: 'MaterialIcons');

  SiteCard({
    this.username = 'User',
    this.caption = 'This is a beautiful place!',
    this.date,
    this.imageUrl = "",
  });

  @override
  _SiteCardState createState() => _SiteCardState();
}

class _SiteCardState extends State<SiteCard> {
  var likes = 0;
  var dislikes = 0;
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: screenWidth * 0.85,
      height: screenHeight * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Row(
          children: [
            // travel log image
            Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.imageUrl,
                    fadeInDuration: const Duration(milliseconds: 10),
                    placeholder: (context, url) => LoadingRotating.square(
                      duration: Duration(milliseconds: 500),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                )),
            // travel log text
            Expanded(
              flex: 3,
              child: Container(
                color: Color(0xCC40D9FF),
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 10, right: 5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: AutoSizeText(
                              widget.username,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.black),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        // caption
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.2 * 0.6,
                          padding:
                              EdgeInsets.only(top: 10, bottom: 10, left: 20),
                          child: AutoSizeText(
                            widget.caption,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                            // maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(right: 10, bottom: 5),
                      child: Text(
                        widget.date.substring(0, widget.date.length - 10),
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expanded(
            //   flex: 3,
            //   child: Container(
            //     color: Color(0xFF40D9FF),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding: EdgeInsets.only(top: 15, left: 10),
            //           child: Text(
            //             widget.username,
            //             style: TextStyle(fontSize: 20),
            //           ),
            //         ),
            //         // caption
            //         Container(
            //           width: double.infinity,
            //           height: screenHeight * 0.2 * 0.35,
            //           padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
            //           child: Text(
            //             widget.caption,
            //             style: TextStyle(fontSize: 15),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 15, left: 5),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                 child: Row(
            //                   children: [
            //                     IconButton(
            //                       splashRadius: 0.1,
            //                       constraints: BoxConstraints(),
            //                       icon: Icon(
            //                         Icons.favorite,
            //                         color:
            //                             liked ? Colors.redAccent : Colors.grey,
            //                       ),
            //                       onPressed: () {
            //                         if (!liked) {
            //                           setState(() => likes += 1);
            //                           liked = true;
            //                         } else {
            //                           setState(() => likes -= 1);
            //                           liked = false;
            //                         }
            //                       },
            //                     ),
            //                     Text(
            //                       likes.toString(),
            //                       style: TextStyle(fontSize: 15),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Container(
            //                 alignment: Alignment.bottomRight,
            //                 padding: EdgeInsets.only(right: 10),
            //                 child: Text(
            //                   widget.date.substring(0, widget.date.length - 10),
            //                   style: TextStyle(fontSize: 10),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
