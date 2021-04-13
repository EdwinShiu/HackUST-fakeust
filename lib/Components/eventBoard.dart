import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EventBoard extends StatefulWidget {
  @override
  EventBoardState createState() => EventBoardState();
}

class EventBoardState extends State<EventBoard> {
  var eventIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: CarouselSlider(
              options: CarouselOptions(
                height: screenHeight * 0.2,
                viewportFraction: screenHeight * 0.2 / (screenWidth - 20),
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) {
                  print('event: ' + index.toString());
                  setState(() {
                    eventIndex = index;
                    print(eventIndex);
                  });
                },
              ),
              items: [0, 1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(child: Text(i.toString())),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Color(0xFF44CF73),
              ),
              child: Center(child: Text('Event $eventIndex')),
            ),
          ),
        ],
      ),
    );
  }
}
