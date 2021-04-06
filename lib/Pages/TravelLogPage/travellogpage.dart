import 'package:flutter/material.dart';

import '../../Cards/travellogCard.dart';

class TravelLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TimeLine(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: TravelLogCard(),
                    ),
                  ),
                ],
              );
            },
            childCount: 5,
          ),
        ),
      ],
    );
  }
}
