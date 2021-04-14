import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hackust_fakeust/states/currentUser.dart';
import 'package:provider/provider.dart';
import '../Components/LeaderBoard.dart';

class TravelLogCard extends StatelessWidget {
  final String description;
  final String locationName;
  final imagePath;
  final imageUrl;
  static const IconData bookmark =
      IconData(0xe5f8, fontFamily: 'MaterialIcons');

  TravelLogCard({
    this.locationName = 'DEFAULT TITLE',
    this.description = 'Default caption aaaaaa aaaaaaaaa aaa aaaaaaa aaaaaaaa',
    this.imagePath = "",
    this.imageUrl = "",
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
              child: (this.imagePath == "")
                  ? Container(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: imageUrl,
                        fadeInDuration: const Duration(milliseconds: 10),
                        // imageUrl: post.getImageURL(),
                        placeholder: (context, url) => LoadingRotating.square(
                          duration: Duration(milliseconds: 500),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
                  : Container(
                      // image background
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(this.imagePath),
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
                        this.locationName,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    // caption
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Text(
                        this.description,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Text(
                        this.description,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
