import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Cards/travellogCard.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TravelLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            child: Text("Travel Log"),
          ),
          Expanded(
            child: ListView(
              children: List.generate(
                10,
                (index) => TimelineTile(
                  alignment: TimelineAlign.start,
                  lineXY: 0.05,
                  endChild: TravelLogCard(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
