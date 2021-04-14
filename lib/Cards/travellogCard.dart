import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TravelLogCard extends StatelessWidget {
  final String description;
  final String locationName;
  final String date;
  final imagePath;
  final imageUrl;
  static const IconData bookmark =
      IconData(0xe5f8, fontFamily: 'MaterialIcons');

  TravelLogCard({
    this.locationName = 'DEFAULT TITLE',
    this.description = 'Default caption aaaaaa aaaaaaaaa aaa aaaaaaa aaaaaaaa',
    this.date,
    this.imagePath = "",
    this.imageUrl = "",
  });

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
              child: (this.imagePath == "")
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 10),
                      child: Text(
                        this.locationName,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    // caption
                    Container(
                      width: double.infinity,
                      height: screenHeight * 0.2 * 0.6,
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                      child: Text(
                        this.description,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        this.date.substring(0, this.date.length - 10),
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
