import 'package:flutter/material.dart';

class LogCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // return Padding(
    //   padding: const EdgeInsets.only(left: 40),
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
                  // color: Colors.lightBlue,
                  // height: screenHeight * 0.2,
                  // // width: screenWidth * 0.85 * 0.4,
                  // child: Image.asset('assets/images/hike.jpg')),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logCard.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.amber,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15, right: 50),
                      // padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'TITLE',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      // padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam posuere, metus eu ',
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
