import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hackust_fakeust/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'eventBoard.dart';

class EventMovingBlock extends StatefulWidget {
  final List<EventDetail> eventDetailList;
  final int eventValue;
  final ValueSetter setPage;

  EventMovingBlock(
      {Key key,
      @required this.eventDetailList,
      @required this.eventValue,
      @required this.setPage})
      : super(key: key);

  @override
  EventMovingBlockState createState() => EventMovingBlockState(eventValue);
}

class EventMovingBlockState extends State<EventMovingBlock> {
  var eventIndex;

  EventMovingBlockState(this.eventIndex);

  String _fromDateToDateFormatter(DateTime startDate, DateTime endDate) {
    String startDateString = startDate.toIso8601String().substring(0, 10);
    String endDateString = endDate.toIso8601String().substring(0, 10);
    return 'From $startDateString to $endDateString';
  }

  bool _hasJoined(String uid, List<String> participants) {
    if (participants == null) {
      return false;
    }
    return participants.firstWhere((participant) => participant == uid,
            orElse: () => null) !=
        null;
  }

  Future<bool> _putUidToEvent(String uid, String eventIndex) async {
    // First fetch firebase again
    // Then check list contain uid
    // If no post uid to participants
    final DocumentSnapshot eventDoc = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventIndex)
        .get();
    List<String> eventParticipationList =
        List<String>.from(eventDoc.data()['participants']);
    if (_hasJoined(uid, eventParticipationList)) {
      return false;
    } else {
      eventParticipationList.add(uid);
      eventDoc.reference.update({
        'participants': eventParticipationList,
      });
      return true;
    }
  }

  Future<void> _joinedDialog(context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('You have joined this event.'),
          ),
          titleTextStyle: Theme.of(context).textTheme.bodyText1,
        );
      },
    );
  }

  Widget carouselSlider(double screenHeight, double screenWidth) {
    final int length = widget.eventDetailList.length;
    switch (length) {
      case 1:
        return Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                height: screenHeight * 0.17,
                width: screenHeight * 0.17,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: widget.eventDetailList[0].color,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    widget.eventDetailList[0].name.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 28),
                  ),
                ),
              ),
            ],
          ),
        );
      case 2:
        return Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    eventIndex = 0;
                  });
                },
                child: Container(
                  height: screenHeight * 0.17,
                  width: screenHeight * 0.17,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: widget.eventDetailList[0].color,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.eventDetailList[0].name.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 28),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    eventIndex = 1;
                  });
                },
                child: Container(
                  height: screenHeight * 0.17,
                  width: screenHeight * 0.17,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: widget.eventDetailList[1].color,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      widget.eventDetailList[1].name.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 28),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      default:
        return Padding(
          padding: EdgeInsets.only(top: 10),
          child: CarouselSlider(
            options: CarouselOptions(
              initialPage: eventIndex,
              height: screenHeight * 0.2,
              viewportFraction: screenHeight * 0.2 / (screenWidth - 20),
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              onPageChanged: (index, reason) {
                setState(() {
                  eventIndex = index;
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
                      color: eventDetail.color,
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
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the height of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    String uid = Provider.of<CurrentUser>(context).getUid;
    return Column(
      children: [
        carouselSlider(screenHeight, screenWidth),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: widget?.eventDetailList[eventIndex]?.color,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.6,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Description:',
                            style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(height: 4),
                        SizedBox(
                          height: 80, // 5x fontSize
                          child: Text(
                            widget?.eventDetailList[eventIndex]?.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(height: 1),
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
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFFFFFFF)),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                Theme.of(context).textTheme.bodyText1),
                          ),
                          onPressed: () async {
                            if (_hasJoined(
                                uid,
                                widget?.eventDetailList[eventIndex]
                                    ?.participants)) {
                              // Joined
                              _joinedDialog(context);
                            } else {
                              var result = await _putUidToEvent(
                                  uid, eventIndex.toString());
                              if (result) {
                                widget.setPage(eventIndex);
                              } else {
                                _joinedDialog(context);
                              }
                            }
                          },
                          child: Text(
                            _hasJoined(
                                    uid,
                                    widget?.eventDetailList[eventIndex]
                                        ?.participants)
                                ? 'Joined'
                                : 'Join',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    fontSize: 20, color: Color(0xFF333333)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
