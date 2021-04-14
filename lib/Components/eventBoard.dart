import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackust_fakeust/Components/eventMovingBlock.dart';
import 'package:loading_animations/loading_animations.dart';

class EventBoard extends StatefulWidget {
  @override
  EventBoardState createState() => EventBoardState();
}

class EventBoardState extends State<EventBoard> {
  int eventValue = 0;

  void setPage(index) {
    setState(() {
      eventValue = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<EventDetail>>(
        future: _EventDataBase().eventDetailList,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return LoadingRotating.square(
              duration: Duration(milliseconds: 500),
            );
          }
          if (snapshot.data.length == 0) {
            return Center(
              child: Text(
                'No Event',
                style: Theme.of(context).textTheme.headline1,
              ),
            );
          }
          List<EventDetail> eventDetailList = snapshot.data;
          return EventMovingBlock(
            eventDetailList: eventDetailList,
            eventValue: eventValue,
            setPage: setPage,
          );
        },
      ),
    );
  }
}

class _EventDataBase {
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('events');

  Future<List<EventDetail>> get eventDetailList async {
    return List<EventDetail>.from(
        (await _eventCollectionData()).docs.map((doc) {
      var docData = doc.data();
      return EventDetail(
        name: docData['event_name'],
        reward: docData['reward'].toDouble(),
        description: docData['description'],
        color: Color(int.parse(docData['color'])),
        participants: List<String>.from(docData['participants']),
        startDate: new DateTime.fromMillisecondsSinceEpoch(
            docData['start_date'].seconds * 1000),
        endDate: new DateTime.fromMillisecondsSinceEpoch(
            docData['end_date'].seconds * 1000),
      );
    }));
  }

  Future<QuerySnapshot> _eventCollectionData() async {
    return await eventCollection.get();
  }
}

class EventDetail {
  String name;
  double reward;
  String description;
  List<String> participants;
  Color color;
  DateTime startDate, endDate;

  EventDetail(
      {@required this.name,
      @required this.reward,
      @required this.description,
      @required this.participants,
      @required this.color,
      @required this.startDate,
      @required this.endDate});
}
