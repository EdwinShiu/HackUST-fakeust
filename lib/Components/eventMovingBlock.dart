import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'eventBoard.dart';

class EventMovingBlock extends StatefulWidget {
  final List<EventDetail> eventDetailList;

  EventMovingBlock({Key key, @required this.eventDetailList}) : super(key: key);

  @override
  EventMovingBlockState createState() => EventMovingBlockState();
}

class EventMovingBlockState extends State<EventMovingBlock> {
  var eventIndex = 0;

  String _fromDateToDateFormatter(DateTime startDate, DateTime endDate) {
    String startDateString = startDate.toIso8601String().substring(0, 10);
    String endDateString = endDate.toIso8601String().substring(0, 10);
    return 'From $startDateString to $endDateString';
  }

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
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
            items: widget.eventDetailList.map((eventDetail) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        eventDetail.name.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 28),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: widget?.eventDetailList[eventIndex]?.color,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Description:',
                          style: Theme.of(context).textTheme.bodyText2),
                      SizedBox(height: 4),
                      SizedBox(
                        height: 80, // 5x fontSize
                        child: Flexible(
                          child: Text(
                            widget?.eventDetailList[eventIndex]?.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(height: 1),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Date:',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 4),
                      Text(
                        _fromDateToDateFormatter(
                            widget?.eventDetailList[eventIndex]?.startDate,
                            widget?.eventDetailList[eventIndex]?.endDate),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 20),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Reward:',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Score ${widget?.eventDetailList[eventIndex]?.reward.toString()}x',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          Theme.of(context).textTheme.bodyText1),
                    ),
                    onPressed: () {
                      print('TomLam');
                    },
                    child: Text(
                      'Join',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 20, color: Color(0xFF333333)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
