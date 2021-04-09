import 'package:flutter/material.dart';

class SiteCard extends StatefulWidget {
  final String username;
  final String caption;
  static const IconData bookmark =
      IconData(0xe5f8, fontFamily: 'MaterialIcons');

  SiteCard({
    this.username = 'USERNAME',
    this.caption = 'Default caption aaaaaa aaaaaaaaa aaa aaaaaaa aaaaaaaa',
  });

  @override
  _SiteCardState createState() => _SiteCardState();
}

class _SiteCardState extends State<SiteCard> {
  var likes = 0;
  var dislikes = 0;
  var liked = 0;

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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logCard.jpeg"),
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
                        this.widget.username,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    // caption
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Text(
                        this.widget.caption,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      child: Row(
                        children: [
                          IconButton(
                            constraints: BoxConstraints(),
                            icon: Icon(Icons.thumb_up),
                            onPressed: () {
                              if (liked <= 0)
                                setState(() {
                                  likes += 1;
                                  if (liked != 0) dislikes -= 1;
                                });
                              liked = 1;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 40),
                            child: Text(
                              likes.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          IconButton(
                            constraints: BoxConstraints(),
                            icon: Icon(Icons.thumb_down),
                            onPressed: () {
                              if (liked >= 0) {
                                setState(() => dislikes += 1);
                                liked = -1;
                                if (liked != 0) likes -= 1;
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              dislikes.toString(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
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