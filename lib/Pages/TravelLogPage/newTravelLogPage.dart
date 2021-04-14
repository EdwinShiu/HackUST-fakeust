import 'package:flutter/material.dart';
import 'package:hackust_fakeust/Cards/travellogCard.dart';
import 'package:hackust_fakeust/states/currentUser.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TravelLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<CurrentUser>(context).getUid;
    return Material(
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.05,
                width: double.infinity,
                child: Text(
                  "Travel Log",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("posts")
                    .where('uid', isEqualTo: uid)
                    .get(),
                builder: (context, snapshot) {
                  // for (var doc in snapshot.data.docs) print(doc['description']);
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView(
                      children: List.generate(
                        snapshot.data.docs.length,
                        (index) => TimelineTile(
                          beforeLineStyle: LineStyle(
                            color: Colors.blue,
                            thickness: 6,
                          ),
                          afterLineStyle: LineStyle(
                            color: Colors.blue,
                            thickness: 6,
                          ),
                          indicatorStyle: IndicatorStyle(
                            width: 25,
                            indicator: Container(
                              decoration: new BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          alignment: TimelineAlign.start,
                          lineXY: 0.05,
                          endChild: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TravelLogCard(
                              locationName: snapshot.data.docs[index]
                                  ['location_name'],
                              description: snapshot.data.docs[index]
                                  ['description'],
                              imageUrl: snapshot.data.docs[index]['image_URL'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
